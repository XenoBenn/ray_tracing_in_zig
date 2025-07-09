x: f32,
y: f32,
z: f32,

const Vec3 = @This();

pub fn init(x: f32, y: f32, z: f32) Vec3 {
    return .{ .x = x, .y = y, .z = z };
}

pub fn length(vec: Vec3) f32 {
    return @sqrt(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z);
}

pub fn add(v: Vec3, w: Vec3) Vec3 {
    return .{
        .x = v.x + w.x,
        .y = v.y + w.y,
        .z = v.z + w.z,
    };
}

pub fn scalarAdd(v: Vec3, t: f32) Vec3 {
    return .{
        .x = v.x + t,
        .y = v.y + t,
        .z = v.z + t,
    };
}

pub fn subs(v: Vec3, w: Vec3) Vec3 {
    return .{
        .x = v.x - w.x,
        .y = v.y - w.y,
        .z = v.z - w.z,
    };
}

pub fn subs4(v: Vec3, w: Vec3, a: Vec3, b: Vec3) Vec3 {
    return .{
        .x = v.x - w.x - a.x - b.x,
        .y = v.y - w.y - a.y - b.y,
        .z = v.z - w.z - a.z - b.z,
    };
}

pub fn scalarSubs(v: Vec3, t: f32) Vec3 {
    return .{
        .x = v.x - t,
        .y = v.y - t,
        .z = v.z - t,
    };
}

pub fn mul(v: Vec3, w: Vec3) Vec3 {
    return .{
        .x = v.x * w.x,
        .y = v.y * w.y,
        .z = v.z * w.z,
    };
}

pub fn scalarMul(v: Vec3, t: f32) Vec3 {
    return .{
        .x = v.x * t,
        .y = v.y * t,
        .z = v.z * t,
    };
}

pub fn div(v: Vec3, w: Vec3) Vec3 {
    return .{
        .x = v.x / w.x,
        .y = v.y / w.y,
        .z = v.z / w.z,
    };
}

pub fn scalarDiv(v: Vec3, t: f32) Vec3 {
    return .{
        .x = v.x / t,
        .y = v.y / t,
        .z = v.z / t,
    };
}

pub fn scale(v: Vec3, c: f32) Vec3 {
    return .{
        .x = v.x * c,
        .y = v.y * c,
        .z = v.z * c,
    };
}

pub fn dot(v: Vec3, w: Vec3) f32 {
    const result: f32 = v.x * w.x + v.y * w.y + v.z * w.z;
    return result;
}
