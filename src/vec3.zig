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
