if ((blink_timer div 6) mod 2 == 0) {
    if (sprite_index != -1) {
        draw_self();
    } else {
        draw_set_color(c_yellow);
        draw_triangle(x, y - 28, x - 28, y + 24, x + 28, y + 24, false);
        draw_set_color(c_black);
        draw_text(x - 4, y - 4, "!");
        draw_set_color(c_white);
    }
}
