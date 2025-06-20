# Ray Tracing in One Weekend (Zig Version)

This is the **Zig** version of *Ray Tracing in One Weekend*.

## How to Build

### Windows

- Using redirection operator:

  ```powershell
  zig build run > image.ppm
  ```

- If the redirection operator doesn't work due to line ending differences, use:

  ```powershell
  zig build run | Set-Content image.ppm -Encoding String
  ```

### Linux / macOS

```bash
zig build run > image.ppm
```
