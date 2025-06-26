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
    v.x += w.x;
    v.y += w.y;
    v.z += w.z;
    return v;
}

pub fn subs(v: Vec3, w: Vec3) Vec3 {
    v.x -= w.x;
    v.y -= w.y;
    v.z -= w.z;
    return v;
}

pub fn mul(v: Vec3, w: Vec3) Vec3 {
    v.x *= w.x;
    v.y *= w.y;
    v.z *= w.z;
    return v;
}

pub fn scale(v: Vec3, c: f32) Vec3 {
    v.x *= c;
    v.y *= c;
    v.z *= c;
    return v;
}

pub fn dot(v: Vec3, w: Vec3) f32 {
    return .{v.x * w.x + v.y * w.y + v.z * w.z};
}
