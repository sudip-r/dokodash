if (sprite_index != -1) {
    draw_self();
} else {
    draw_set_color(c_red);
    draw_rectangle(x - 28, y - 28, x + 28, y + 28, false);
    draw_set_color(c_white);
}
