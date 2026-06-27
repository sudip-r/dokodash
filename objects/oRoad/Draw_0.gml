var road_x = 120;
var road_w = 480;

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

// Road edge
draw_set_color(make_color_rgb(100, 75, 45));
draw_rectangle(road_x, 0, road_x + 8, room_height, false);
draw_rectangle(road_x + road_w - 8, 0, road_x + road_w, room_height, false);