const std = @import("std");
const vec3 = @import("vec3.zig");

const Ray = struct {
    orig: vec3,
    dir: vec3,
};
