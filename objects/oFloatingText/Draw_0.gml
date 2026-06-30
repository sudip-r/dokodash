draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(text_color);
draw_set_alpha(text_alpha);

draw_text(x, y, display_text);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
