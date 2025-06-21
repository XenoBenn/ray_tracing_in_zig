const std = @import("std");
const color = @import("vec3.zig");

// const Color = @This();

pub fn write_color(pixel_color: color) !void {
    const r: f32 = pixel_color.x;
    const g: f32 = pixel_color.y;
    const b: f32 = pixel_color.z;

    const rbyte: i32 = @intFromFloat(255.999 * r);
    const gbyte: i32 = @intFromFloat(255.999 * g);
    const bbyte: i32 = @intFromFloat(255.999 * b);

    // TODO: Use zstbi to write to a png.
    try std.io.getStdOut().writer().print("{} {} {}\n", .{ rbyte, gbyte, bbyte });
}
