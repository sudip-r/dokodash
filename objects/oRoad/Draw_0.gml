var road_x = 120;
var road_w = 480;
var road_center = road_x + road_w * 0.5;
var scroll_y = 0;

var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    scroll_y = game.distance mod 96;
}

// Background grass
draw_set_color(make_color_rgb(70, 130, 70));
draw_rectangle(0, 0, room_width, room_height, false);

// Main dirt road
draw_set_color(make_color_rgb(150, 110, 70));
draw_rectangle(road_x, 0, road_x + road_w, room_height, false);

// Lane separators
draw_set_color(make_color_rgb(180, 140, 95));
draw_rectangle(280, 0, 288, room_height, false);
draw_rectangle(432, 0, 440, room_height, false);

// Center trail marks
draw_set_color(make_color_rgb(120, 90, 55));
for (var mark_y = -96 + scroll_y; mark_y < room_height + 96; mark_y += 96) {
    draw_rectangle(road_center - 28, mark_y, road_center + 28, mark_y + 36, false);
}

// Road edge
draw_set_color(make_color_rgb(100, 75, 45));
draw_rectangle(road_x, 0, road_x + 8, room_height, false);
draw_rectangle(road_x + road_w - 8, 0, road_x + road_w, room_height, false);
