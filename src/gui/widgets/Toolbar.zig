const std = @import("std");
const Allocator = std.mem.Allocator;
const ArrayList = std.ArrayList;

const nvg = @import("nanovg");
const gui = @import("../gui.zig");
const Rect = @import("../geometry.zig").Rect;

const Self = @This();

widget: gui.Widget,
allocator: *Allocator,

has_grip: bool = false,

separators: ArrayList(*gui.Widget),

pub fn init(allocator: *Allocator, rect: Rect(f32)) !*Self {
    var self = try allocator.create(Self);
    self.* = Self{
        .widget = gui.Widget.init(allocator, rect),
        .allocator = allocator,
        .separators = ArrayList(*gui.Widget).init(allocator),
    };

    self.widget.drawFn = draw;

    return self;
}

pub fn deinit(self: *Self) void {
    for (self.separators.items) |widget| {
        self.allocator.destroy(widget);
    }
    self.separators.deinit();
    self.widget.deinit();
    self.allocator.destroy(self);
}

pub fn addButton(self: *Self, button: *gui.Button) !void {
    button.style = .toolbar;
    button.widget.focus_policy = gui.FocusPolicy.none();
    button.widget.relative_rect.w = 20;
    button.widget.relative_rect.h = 20;
    try self.addWidget(&button.widget);
}

pub fn addSeparator(self: *Self) !void {
    var separator = try self.allocator.create(gui.Widget);
    separator.* = gui.Widget.init(self.allocator, Rect(f32).make(0, 0, 4, 20));
    separator.drawFn = drawSeparator;
    try self.separators.append(separator);
    try self.addWidget(separator);
}

pub fn addWidget(self: *Self, widget: *gui.Widget) !void {
    const pad: f32 = 2;
    var x: f32 = 0;
    for (self.widget.children.items) |child| {
        x += pad + child.relative_rect.w;
    }
    widget.relative_rect.x = x + pad;
    widget.relative_rect.y = pad;
    try self.widget.addChild(widget);
}

fn drawSeparator(widget: *gui.Widget) void {
    const rect = widget.relative_rect;

    nvg.beginPath();
    nvg.rect(rect.x + 1, rect.y + 1, 1, rect.h - 2);
    nvg.fillColor(gui.theme_colors.shadow);
    nvg.fill();
    nvg.beginPath();
    nvg.rect(rect.x + 2, rect.y + 1, 1, rect.h - 2);
    nvg.fillColor(gui.theme_colors.light);
    nvg.fill();
}

fn draw(widget: *gui.Widget) void {
    const self = @fieldParentPtr(Self, "widget", widget);

    const rect = widget.relative_rect;
    gui.drawPanel(rect.x, rect.y, rect.w, rect.h, 1, false, false);

    if (self.has_grip) {
        drawGrip(rect.x + rect.w - 16, rect.y + rect.h - 16);
    }

    widget.drawChildren();
}

fn drawGrip(x: f32, y: f32) void {
    nvg.scissor(x, y, 14, 14);
    defer nvg.resetScissor();

    nvg.beginPath();
    nvg.moveTo(x, y + 16);
    nvg.lineTo(x + 16, y);
    nvg.moveTo(x + 4, y + 16);
    nvg.lineTo(x + 4 + 16, y);
    nvg.moveTo(x + 8, y + 16);
    nvg.lineTo(x + 8 + 16, y);
    nvg.strokeColor(gui.theme_colors.light);
    nvg.stroke();
    nvg.beginPath();
    nvg.moveTo(x + 1, y + 16);
    nvg.lineTo(x + 1 + 16, y);
    nvg.moveTo(x + 5, y + 16);
    nvg.lineTo(x + 5 + 16, y);
    nvg.moveTo(x + 9, y + 16);
    nvg.lineTo(x + 9 + 16, y);
    nvg.strokeColor(gui.theme_colors.shadow);
    nvg.stroke();
}
