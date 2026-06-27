var player = instance_find(oPlayer, 0);
var game = instance_find(oGame, 0);

draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (instance_exists(game)) {
    draw_text(32, 32, game.mission_name);
}

if (instance_exists(player)) {
    draw_text(32, 72, "HP: " + string(player.player_hp));
    draw_text(32, 112, "Points: " + string(player.points));
}

if (instance_exists(game)) {
    var progress = clamp(game.distance / game.finish_distance, 0, 1);
    var percent = floor(progress * 100);

    draw_text(32, 152, "Delivery: " + string(percent) + "%");

    if (game.game_state == "complete") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_text(360, 540, "Delivery Complete!");

        if (instance_exists(player)) {
            draw_text(360, 600, "Points: " + string(player.points));
        }

        draw_text(360, 660, "Tap or Press R to Restart");

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }

    if (game.game_state == "gameover") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        draw_text(360, 540, "Game Over");
        draw_text(360, 600, "Delivery Failed");
        draw_text(360, 660, "Tap or Press R to Restart");

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}
