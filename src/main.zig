const std = @import("std");

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
            const r: f32 = @as(f32, @floatFromInt(i)) / @as(f32, @floatFromInt(image_width - 1));
            const g: f32 = @as(f32, @floatFromInt(j)) / @as(f32, @floatFromInt(image_height - 1));
            const b: f32 = 0.0;

            const ir: i32 = @intFromFloat(255.999 * r);
            const ig: i32 = @intFromFloat(255.999 * g);
            const ib: i32 = @intFromFloat(255.999 * b);

            // TODO: Write data to a file, instead of the console
            try stdout.print("{} {} {}\n", .{ ir, ig, ib });
        }
    }
}
