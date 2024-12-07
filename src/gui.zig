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

pub const WidgetType = enum {
    Label,
    Rect,
};

pub const Widget = struct {
    size: Size,
    position: Position,
    name: []const u8,
    type: WidgetType,

    const Self = @This();

    pub fn init(size: Size, position: Position) Layout {
        return Widget{
            .size = size,
            .position = position,
        };
    }

    pub fn render(self: Self) !void {}

    pub fn handle() !void {}
};

pub fn Rect(comptime T: type) type {
    return struct {
        widget: Widget,

        const Self = @This();

        pub fn init(position: Position, size: Size) Self {
            const widget: Widget = Widget{ .type = WidgetType.Rect, .size = size, .position = position, .name = "Rect" };

            return Self{
                .widget = widget,
            };
        }
    };
}

pub fn Layout(comptime T: type) type {
    return struct {
        const Location = enum {
            right,
            left,
            bottom,
            top,
            center,
        };

        location: Location,
        array: std.ArrayList(T),

        const Self = @This();

        pub fn init(location: Location, array: std.ArrayList(T)) Self {
            return Self{
                .location = location,
                .array = array,
            };
        }

        pub fn calculate(w: Widget, l: Location) void {
            // for each given location calculate what is inside each array list.
            const currentLoc = switch (l) {
                .top => "Top",
                else => "Center",
            };

            std.debug.print("{s}", .{currentLoc});
            std.debug.print("{s}", .{w.name});
        }

        pub fn pushWidget(self: Self, widget: T) !void {
            if (rl.isWindowFullscreen) { // TODO: some positional calculations required for where it is going to render.}
                self.array.append(widget); // adds it to the array.
                try widget.render().?;
            }
        }
    };
}
