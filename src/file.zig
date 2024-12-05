const std = @import("std");
const fs = std.fs;
const heap = std.heap;

pub const FS = struct {
    start: []const u8,

    pub fn init(start_path: []const u8) FS {
        return FS{
            .start = start_path,
        };
    }

    pub fn run() !void {
        var dir: std.fs.Dir = try std.fs.openDirAbsolute("/home/denglish/projects/kilo-fs", .{
            .access_sub_paths = true,
            .iterate = true,
            .no_follow = true,
        });
        defer dir.close();

        var itr = dir.iterate();

        while (try itr.next()) |entry| {
            if (entry.kind == .file) {
                std.debug.print("File: {s}\n", .{entry.name});
            }

            if (entry.kind == .directory) {
                std.debug.print("Dir: {s}\n", .{entry.name});
            }
        }
    }
};
