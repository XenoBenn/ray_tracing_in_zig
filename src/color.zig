const std = @import("std");
const color = @import("vec3.zig");
const ray = @import("ray.zig");

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

pub fn rayc(r: ray) color {
    const unit_direction = r.dir;
    const a: f32 = 0.5 * (unit_direction.y + 1.0);

    return color.add(color.scale(color.init(1.0, 1.0, 1.0), (1.0 - a)), color.scale(color.init(0.5, 0.7, 1.0), a));
}
