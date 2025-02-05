const std = @import("std");
const Allocator = std.mem.Allocator;

const nvg = @import("nanovg");
const gui = @import("../gui.zig");
const event = @import("../event.zig");
const Point = @import("../geometry.zig").Point;
const Rect = @import("../geometry.zig").Rect;

const Button = @This();

pub const ButtonStyle = enum(u8) {
    default,
    toolbar,
};

widget: gui.Widget,
allocator: *Allocator,
text: [:0]const u8,
font_size: f32 = 9,
iconFn: ?fn () void = null,
icon_x: f32 = 2,
icon_y: f32 = 2,
style: ButtonStyle = .default,
enabled: bool = true,

hovered: bool = false,
pressed: bool = false,
checked: bool = false,

auto_repeat_timer: gui.Timer,
auto_repeat_interval: u32 = 0, // in milliseconds

onClickFn: ?fn (*Self) void = null,
onEnterFn: ?fn (*Self) void = null,
onLeaveFn: ?fn (*Self) void = null,

const Self = @This();

pub fn init(allocator: *Allocator, rect: Rect(f32), text: [:0]const u8) !*Self {
    var self = try allocator.create(Self);
    self.* = Self{
        .widget = gui.Widget.init(allocator, rect),
        .allocator = allocator,
        .text = text,
        .auto_repeat_timer = gui.Timer{
            .on_elapsed_fn = onAutoRepeatTimerElapsed,
            .ctx = @ptrToInt(self),
        },
    };
    self.widget.focus_policy.mouse = true;
    self.widget.focus_policy.keyboard = true;

    self.widget.drawFn = draw;
    self.widget.onMouseDownFn = onMouseDown;
    self.widget.onMouseUpFn = onMouseUp;
    self.widget.onEnterFn = onEnter;
    self.widget.onLeaveFn = onLeave;

    return self;
}

pub fn deinit(self: *Self) void {
    self.auto_repeat_timer.stop();
    self.widget.deinit();
    self.allocator.destroy(self);
}

pub fn click(self: *Self) void {
    if (!self.enabled) return;
    if (self.onClickFn) |clickFn| {
        clickFn(self);
    }
}

pub fn onMouseDown(widget: *gui.Widget, mouse_event: *const event.MouseEvent) void {
    const self = @fieldParentPtr(Self, "widget", widget);
    if (!self.enabled) return;
    const mouse_position = Point(f32).make(mouse_event.x, mouse_event.y);
    self.hovered = widget.getRect().contains(mouse_position);
    if (mouse_event.button == .left) {
        if (self.hovered) {
            self.pressed = true;
            if (self.auto_repeat_interval > 0) {
                self.click();
                self.auto_repeat_timer.start(self.auto_repeat_interval);
            }
        }
    }
}

fn onMouseUp(widget: *gui.Widget, mouse_event: *const event.MouseEvent) void {
    const self = @fieldParentPtr(Self, "widget", widget);
    if (!self.enabled) return;
    const mouse_position = Point(f32).make(mouse_event.x, mouse_event.y);
    self.hovered = widget.getRect().contains(mouse_position);
    if (mouse_event.button == .left) {
        self.pressed = false;
        self.auto_repeat_timer.stop();
        if (self.hovered and self.auto_repeat_interval == 0) {
            self.click();
        }
    }
}

fn onEnter(widget: *gui.Widget) void {
    const self = @fieldParentPtr(Self, "widget", widget);
    self.hovered = true;
    if (self.onEnterFn) |enterFn| enterFn(self);
}

fn onLeave(widget: *gui.Widget) void {
    const self = @fieldParentPtr(Self, "widget", widget);
    self.hovered = false;
    if (self.onLeaveFn) |leaveFn| leaveFn(self);
}

fn onAutoRepeatTimerElapsed(context: usize) void {
    var button = @intToPtr(*Button, context);
    if (button.onClickFn) |onClickFn| {
        onClickFn(button);
    }
}

pub fn draw(widget: *gui.Widget) void {
    const self = @fieldParentPtr(Self, "widget", widget);

    const rect = widget.relative_rect;
    switch (self.style) {
        .default => {
            gui.drawPanel(rect.x + 1, rect.y + 1, rect.w - 2, rect.h - 2, 1, self.enabled and self.hovered, (self.enabled and self.pressed) or self.checked);

            const is_focused = widget.isFocused();

            // border
            nvg.beginPath();
            // if (is_focused) {
            //     nvg.rect(rect.x + 1, rect.y + 1, rect.w - 2, rect.h - 2);
            //     nvg.strokeWidth(2);
            // } else {
            nvg.rect(rect.x + 0.5, rect.y + 0.5, rect.w - 1, rect.h - 1);
            // }
            nvg.strokeColor(if (is_focused) nvg.rgb(0, 0, 0) else gui.theme_colors.border);
            nvg.stroke();
            nvg.strokeWidth(1);
        },
        .toolbar => {
            if ((self.enabled and self.hovered) or self.checked) {
                const depth: f32 = 1;
                gui.drawPanel(rect.x, rect.y, rect.w, rect.h, depth, false, (self.enabled and self.pressed) or self.checked);
            }
        },
    }
    // nvg.beginPath();
    // nvg.roundedRect(rect.x + 1.5, rect.y + 1.5, rect.w - 3, rect.h - 3, 1);
    // nvg.fillColor(gui.theme_colors.background);
    // nvg.fill();
    // nvg.strokeColor(gui.theme_colors.light);
    // nvg.stroke();
    // nvg.beginPath();
    // nvg.roundedRect(rect.x + 0.5, rect.y + 0.5, rect.w - 1, rect.h - 1, 2);
    // nvg.strokeColor(gui.theme_colors.border);
    // nvg.stroke();

    nvg.fontFace("guifont");
    nvg.fontSize(gui.pixelsToPoints(self.font_size));
    nvg.textAlign(.{ .horizontal = .center, .vertical = .middle});
    nvg.fillColor(nvg.rgb(0, 0, 0));
    _ = nvg.text(rect.x + 0.5 * rect.w, rect.y + 0.5 * rect.h, self.text);

    if (self.iconFn) |iconFn| {
        nvg.save();
        nvg.translate(rect.x + self.icon_x, rect.y + self.icon_y);
        iconFn();
        nvg.restore();
    }
}
