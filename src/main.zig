const std = @import("std");
const vec3 = @import("vec3.zig");
const color = @import("color.zig");
const ray = @import("ray.zig");

const ray_color = vec3.init(0, 0, 0);

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    // Image
    // const aspect_ratio: f32 = 16.0 / 9.0;
    const image_width: i32 = 400;

    // Calculate the image height, and ensure it is 1
    const image_height: i32 = 225;
    // var image_height: i32 = image_width / @as(i32, @intFromFloat(aspect_ratio));
    // image_height = if (image_height < 1) 1 else image_height;

    // Camera
    const focal_length: f32 = 1.0;
    const viewport_height: f32 = 2.0;
    const viewport_width: f32 = viewport_height * (@as(f32, @floatFromInt(image_width)) / @as(f32, @floatFromInt(image_height)));
    const camera_center = vec3.init(0, 0, 0);

    // Calculate the vectors across the horizontal and down vertical vieport edges
    const viewport_u = vec3.init(viewport_width, 0, 0);
    const viewport_v = vec3.init(0, -viewport_height, 0);

    // Calculate the vertical and horizontal delta vectors from pixel to pixel
    const pixel_delta_u = vec3.scalarDiv(viewport_u, @as(f32, @floatFromInt(image_width)));
    const pixel_delta_v = vec3.scalarDiv(viewport_v, @as(f32, @floatFromInt(image_height)));

    // Calculate the location of the upper left pixel
    const viewport_upper_left = vec3.subs(camera_center, vec3.subs((vec3.init(0, 0, focal_length)), vec3.subs((vec3.scalarDiv(viewport_u, 2)), vec3.scalarDiv(viewport_v, 2))));
    const pixel00_loc = vec3.add(viewport_upper_left, vec3.scale((vec3.add(pixel_delta_u, pixel_delta_v)), 0.5));

    // Render
    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    var remaining_lines: i32 = image_height;
    for (0..@as(usize, @intCast(image_height))) |j| {
        std.debug.print("Scanlines remaining: {}\n", .{remaining_lines});
        remaining_lines -= 1;
        for (0..image_width) |i| {
            const pixel_center = vec3.add(pixel00_loc, vec3.add(vec3.scale(pixel_delta_u, @as(f32, @floatFromInt(i))), vec3.scale(pixel_delta_v, @as(f32, @floatFromInt(j)))));
            const ray_direction = vec3.subs(pixel_center, camera_center);
            const r = ray.init(camera_center, ray_direction);
            const pixel_color = color.rayc(r);

            // TODO: Write data to a file, instead of the console
            try color.write_color(pixel_color);
        }
    }
}
