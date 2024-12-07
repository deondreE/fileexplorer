const std = @import("std");
const rl = @import("raylib");

pub var Size = struct {
    width: i32,
    height: i32,
};

pub var Position = struct {
    x: i32,
    y: i32,
};

pub const Widget = struct {
    size: Size,
    position: Position,

    pub fn init(size: Size, position: Position) Layout {
        return Widget{
            .size = size,
            .position = position,
        };
    }
};

pub const Layout = struct {
    startPos: Position,

    pub fn init(startPos: Position) Layout {
        return Layout{
            .startPos = startPos,
        };
    }

    // calculate each position inside the layout inside here.
    pub fn calculate() void {}

    // push a given widget to the stack to be rendered when it is needed. If not do not render.
    pub fn pushWidget(self: Layout, newWidget: Widget) !void {}

    pub fn render() void {}
};

pub const Label = struct {};
