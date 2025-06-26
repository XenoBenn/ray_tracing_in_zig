const std = @import("std");
const vec3 = @import("vec3.zig");

orig: vec3,
dir: vec3,

const Ray = @This();

pub fn init(orig: vec3, dir: vec3) Ray {
    return .{ .orig = orig, .dir = dir };
}

// Lookin direction
pub fn at(t: f64) vec3 {
    return vec3.add(.orig, vec3.scalarMul(.dir, t));
}
