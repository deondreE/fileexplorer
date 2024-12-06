const std = @import("std");
const file = @import("./file.zig");
const rl = @import("raylib");

const Cursor = struct {
    posX: i32,
    posY: i32,

    pub fn set(posX: i32, posY: i32) Cursor {
        return Cursor{
            .posX = posX,
            .posY = posY,
        };
    }
};

const Position = struct {
    x: ?i32,
    y: ?i32,
};

const UIObject = struct {};

const Rect = struct {
    width: i32,
    height: i32,
    cursor: Cursor,
    color: rl.Color,
    grid: bool,
    //    children: []Rect,

    pub fn init(width: i32, height: i32, cursor: Cursor, color: rl.Color, grid: bool) Rect {
        if (grid) {
            return Rect{
                .width = width,
                .height = height,
                .cursor = cursor,
                .color = color,
                .grid = grid,
            };
        } else {
            return Rect{ .width = width, .height = height, .cursor = cursor, .color = color, .grid = grid };
        }
    }

    pub fn render(rect: Rect) void {
        if (rect.grid) {
            rl.drawRectangle(rect.width + 10, 0, rect.width, rect.height, rect.color);
        }

        rl.drawRectangle(rect.cursor.posX, rect.cursor.posY, rect.width, rect.height, rect.color);
        rl.drawText("javascript.js", rect.cursor.posX, rect.height, 10, rl.Color.maroon);
    }
};

pub fn main() !void {
    var screenWidth: i32 = 800;
    var screenHeight: i32 = 400;

    const texture: rl.Texture = rl.loadTexture("home/deondreE/projects/kilo-fs/resources/golang.png");
    const cursor = Cursor.set(rl.getMouseX(), rl.getMouseY());

    rl.initWindow(screenWidth, screenHeight, "kilo-fs");
    defer rl.closeWindow();

    rl.setTargetFPS(60);
    _ = try file.FS.run("/home/denglish/projects/kilo-fs");

    while (!rl.windowShouldClose()) {
        if (rl.isWindowResized() or !rl.isWindowFullscreen()) {
            screenWidth = rl.getScreenWidth();
            screenHeight = rl.getScreenHeight();
        }

        rl.beginDrawing();
        defer rl.endDrawing();

        rl.clearBackground(rl.Color.white);
        rl.drawTexture(texture, @divFloor(screenWidth, 2) - @divFloor(texture.width, 2), @divFloor(screenHeight, 2) - @divFloor(texture.height, 2), rl.Color.white);

        const rect = Rect.init(100, 100, cursor, rl.Color.red, false);
        Rect.render(rect);

        const grid_rect = Rect.init(100, 100, cursor, rl.Color.violet, true);
        Rect.render(grid_rect);
    }
}
