var player = instance_find(oPlayer, 0);
var game = instance_find(oGame, 0);

draw_set_color(c_white);
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (instance_exists(player)) {
    draw_text(32, 32, "HP: " + string(player.player_hp));
    draw_text(32, 72, "Points: " + string(player.points));
}

if (instance_exists(game)) {
    draw_text(32, 112, "Distance: " + string(floor(game.distance)));

    if (game.game_state == "complete") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(360, 600, "Delivery Complete!");
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }

    if (game.game_state == "gameover") {
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_text(360, 600, "Game Over");
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
}
