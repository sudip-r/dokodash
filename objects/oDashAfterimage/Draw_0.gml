if (source_sprite != -1) {
    draw_set_alpha(alpha);
    draw_sprite_ext(
        source_sprite,
        source_image_index,
        x,
        y,
        source_xscale,
        source_yscale,
        0,
        c_white,
        alpha
    );
    draw_set_alpha(1);
}
