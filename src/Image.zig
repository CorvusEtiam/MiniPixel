const std = @import("std");

const Image = @This();

const colormap_len = 0x100;

width: u32,
height: u32,
pixels: []u8,
colormap: ?[]u8 = null,
allocator: *std.mem.Allocator,

pub fn initFromFile(allocator: *std.mem.Allocator, file_path: []const u8) !Image {
    var image_width: u32 = undefined;
    var image_height: u32 = undefined;
    var colormap_entries: u32 = undefined;
    const c_file_path = try std.cstr.addNullByte(allocator, file_path);
    defer allocator.free(c_file_path);
    var err = readPngFileInfo(c_file_path, &image_width, &image_height, &colormap_entries);
    if (err != 0) return error.ReadInfoFail;

    const bytes_per_channel: u32 = if (colormap_entries > 0) 1 else 4; // indexed or rgba
    const image_size = bytes_per_channel * image_width * image_height;

    var self: Image = Image{
        .width = image_width,
        .height = image_height,
        .pixels = try allocator.alloc(u8, image_size),
        .allocator = allocator,
    };
    errdefer self.deinit();
    if (colormap_entries > 0) self.colormap = try allocator.alloc(u8, 4 * colormap_len);

    err = readPngFile(c_file_path, self.pixels.ptr, if (self.colormap) |colormap| colormap.ptr else null);
    if (err != 0) return error.ReadPngFail;

    return self;
}

pub fn initFromMemory(allocator: *std.mem.Allocator, memory: []const u8) !Image {
    var image_width: u32 = undefined;
    var image_height: u32 = undefined;
    var colormap_entries: u32 = undefined;
    var err = readPngMemoryInfo(memory.ptr, memory.len, &image_width, &image_height, &colormap_entries);
    if (err != 0) return error.ReadInfoFail;

    const bytes_per_channel: u32 = if (colormap_entries > 0) 1 else 4; // indexed or rgba
    const image_size = bytes_per_channel * image_width * image_height;

    var self: Image = Image{
        .width = image_width,
        .height = image_height,
        .pixels = try allocator.alloc(u8, image_size),
        .allocator = allocator,
    };
    errdefer self.deinit();
    if (colormap_entries > 0) self.colormap = try allocator.alloc(u8, 4 * colormap_len);

    err = readPngMemory(memory.ptr, memory.len, self.pixels.ptr, if (self.colormap) |colormap| colormap.ptr else null);
    if (err != 0) return error.ReadPngFail;

    return self;
}

pub fn deinit(self: *Image) void {
    self.allocator.free(self.pixels);
    if (self.colormap) |colormap| self.allocator.free(colormap);
}

pub fn writeToFile(self:Image, file_path: []const u8) !void {
    const colormap: [*c]const u8 = if (self.colormap) |colormap| colormap.ptr else null;
    const c_file_path = try std.cstr.addNullByte(self.allocator, file_path);
    defer self.allocator.free(c_file_path);
    const err = writePngFile(c_file_path, self.width, self.height, self.pixels.ptr, colormap, colormap_len);
    if (err != 0) return error.WritePngFail;
}

pub fn writeToMemory(self: Image, allocator: *std.mem.Allocator) ![]const u8 {
    const colormap: [*c]const u8 = if (self.colormap) |colormap| colormap.ptr else null;
    var mem_len: usize = undefined;
    var err = writePngMemory(null, &mem_len, self.width, self.height, self.pixels.ptr, colormap, colormap_len);
    if (err != 0) return error.WritePngDetermineSizeFail;
    const mem = try allocator.alloc(u8, mem_len);
    errdefer allocator.free(mem);
    err = writePngMemory(mem.ptr, &mem_len, self.width, self.height, self.pixels.ptr, colormap, colormap_len);
    if (err != 0) return error.WritePngFail;
    return mem;
}

// implementation in c/png_image.c
extern fn readPngFileInfo(file_path: [*c]const u8, width: [*c]u32, height: [*c]u32, colormap_entries: [*c]u32) callconv(.C) c_int;
extern fn readPngFile(file_path: [*c]const u8, pixels: [*c]const u8, colormap: [*c]const u8) callconv(.C) c_int;
extern fn readPngMemoryInfo(memory: [*c]const u8, len: usize, width: [*c]u32, height: [*c]u32, colormap_entries: [*c]u32) callconv(.C) c_int;
extern fn readPngMemory(memory: [*c]const u8, len: usize, pixels: [*c]const u8, colormap: [*c]const u8) callconv(.C) c_int;
extern fn writePngFile(file_path: [*c]const u8, width: u32, height: u32, pixels: [*c]const u8, colormap: [*c]const u8, colormap_entries: u32) callconv(.C) c_int;
extern fn writePngMemory(memory: [*c]const u8, len: [*c]usize, width: u32, height: u32, pixels: [*c]const u8, colormap: [*c]const u8, colormap_entries: u32) callconv(.C) c_int;
