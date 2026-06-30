draw_set_color(c_black);
draw_rectangle(0, 0, 720, 1280, false);

draw_set_color(c_white);
draw_set_font(-1);

if (screen_state == "title") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(360, 420, title_text);
    draw_text(360, 500, subtitle_text);

    draw_text(360, 760, "Tap to Start");
    draw_text(360, 820, "or Press Enter");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (screen_state == "story") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text_ext(360, 520, story_lines[story_index], 36, 560);

    draw_text(360, 900, "Tap to Continue");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
