const std = @import("std");

// Vec3 and it's functions
const vec3 = @import("vec3.zig");
const vadd = vec3.add;
const vsum = vec3.sum;
const vsub = vec3.subs;
const vmul = vec3.mul;
const vdiv = vec3.div;
const vdot = vec3.dot;
const vscale = vec3.scale;
const vscalardiv = vec3.scalarDiv;

const color = @import("color.zig");
const ray = @import("ray.zig");

const ray_color = vec3.init(0, 0, 0);

fn hit_sphere(center: vec3, radius: f32, r: ray) bool {
    const oc = vsub(center, r.orig);
    const a = vdot(r.dir, r.dir);
    const b = -2.0 * vdot(r.dir, oc);
    const c = vdot(oc, oc) - (radius * radius);
    const discriminant = (b * b) - (4 * a * c);
    if (discriminant >= 0) {
        return true;
    }
    return false;
}

fn rayc(r: ray) vec3 {
    if (hit_sphere(vec3.init(0, 0, -1), 0.5, r)) {
        return vec3.init(1, 0, 0);
    }
    const unit_direction = r.dir;
    const a: f32 = 0.5 * (unit_direction.y + 1.0);

    return vadd(vscale(vec3.init(1.0, 1.0, 1.0), (1.0 - a)), vscale(vec3.init(0.5, 0.7, 1.0), a));
}

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
    const pixel_delta_u = vscalardiv(viewport_u, @as(f32, @floatFromInt(image_width)));
    const pixel_delta_v = vscalardiv(viewport_v, @as(f32, @floatFromInt(image_height)));

    // Calculate the location of the upper left pixel
    const viewport_upper_left = vsub(
        camera_center,
        vsum(.{
            vec3.init(0, 0, focal_length),
            vscalardiv(viewport_u, 2),
            vscalardiv(viewport_v, 2),
        }),
    );

    const pixel00_loc = vadd(viewport_upper_left, vscale((vadd(pixel_delta_u, pixel_delta_v)), 0.5));

    // Render
    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    var remaining_lines: i32 = image_height;
    for (0..@as(usize, @intCast(image_height))) |j| {
        std.debug.print("Scanlines remaining: {}\n", .{remaining_lines});
        remaining_lines -= 1;
        for (0..image_width) |i| {
            const pixel_a = vadd(vscale(pixel_delta_u, @as(f32, @floatFromInt(i))), vscale(pixel_delta_v, @as(f32, @floatFromInt(j))));
            const pixel_center = vadd(pixel00_loc, pixel_a);
            const ray_direction = vsub(pixel_center, camera_center);
            const r = ray.init(camera_center, ray_direction);
            const pixel_color = rayc(r);

            // TODO: Write data to a file, instead of the console
            try color.write_color(pixel_color);
        }
    }
}
