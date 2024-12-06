const std = @import("std");
const fs = std.fs;
const heap = std.heap;

pub const Node = struct {
    keys: []*const u8,
    t: i32,
    C: []Node,
    leaf: bool,
    kNum: i32, // current number of keys.

    pub fn search(self: Node, key: *const u8) *Node {
        var i: i32 = 0;

        if (self.leaf)
            return null;

        while (i < self.kNum) : (i += 1) {
            if (self.keys[i] == key)
                return &self;
        }

        return self.C[i].search(key);
    }

    //    pub fn splitChild(self: Node, value: *const []u8, rootNode: *Node) void {
    // TODO: do this.
    //   }

    //  pub fn insertNonFull(self: Node, key: *const []u8) void {
    //      var i: i32 = self.kNum - 1;
    //      if (leaf) {
    // TODO: find location of new keys.
    //        }
    //   }

    pub fn traverse(self: Node) void {
        var i: i32 = 0;
        while (i < self.kNum) : (i += 1) {
            if (!self.leaf)
                self.C[i].traverse();
            std.debug.print("{s}", .{self.keys[i]});
        }

        if (!self.leaf)
            self.C[i].traverse();
    }
};

pub const Tree = struct {
    root: *Node,
    leaves: []Node,
    t: u32,

    pub fn init() Tree {}

    //    pub fn delete(node: Node) Tree {}

    pub fn traverse(self: Tree) void {
        if (self.root != null)
            self.root.traverse();
    }

    pub fn search(self: Tree, key: []*const u8) *Node {
        if (self.root == null) {
            return null;
        }

        return self.root.search(key);
    }
};

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
