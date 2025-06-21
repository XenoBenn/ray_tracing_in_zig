const std = @import("std");
const vec3 = @import("vec3.zig");
const color = @import("color.zig");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    // Image
    const image_width: i32 = 256;
    const image_height: i32 = 256;

    // Render
    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    var remaining_lines: i32 = image_height;
    for (0..image_height) |j| {
        std.debug.print("Scanlines remaining: {}\n", .{remaining_lines});
        remaining_lines -= 1;
        for (0..image_width) |i| {
            const pixel_color = vec3.init(
                @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(image_width - 1)),
                @as(f32, @floatFromInt(j)) / @as(f32, @floatFromInt(image_height - 1)),
                0.0,
            );
            // // TODO: Write data to a file, instead of the console
            try color.write_color(pixel_color);
        }
    }
}
