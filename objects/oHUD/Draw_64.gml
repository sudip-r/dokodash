var player = instance_find(oPlayer, 0);
var game = instance_find(oGame, 0);

draw_set_font(-1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

if (!instance_exists(game)) {
    exit;
}

var progress = clamp(game.distance / game.finish_distance, 0, 1);
var percent = floor(progress * 100);

if (game.game_state == "playing") {
    draw_text(32, 32, game.mission_name);
    draw_text(32, 62, game.mission_goal_text);

    if (instance_exists(player)) {
        draw_text(32, 112, "HP: " + string(player.player_hp));
        draw_text(32, 152, "Points: " + string(player.points));
        draw_text(32, 192, "Doko Items: " + string(player.doko_items));
    }

    draw_text(32, 232, "Delivery: " + string(percent) + "%");

    if (game.slow_timer > 0) {
        draw_text(32, 272, "Slowed!");
    }
}

if (game.game_state == "complete") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    var stars_text = "";

    repeat (game.star_count) {
        stars_text += "*";
    }

    repeat (3 - game.star_count) {
        stars_text += "-";
    }

    draw_text(360, 420, "Delivery Complete!");
    draw_text(360, 490, "Stars: " + stars_text);
    draw_text(360, 560, "Points: " + string(game.final_points));
    draw_text(360, 620, "Doko Items: " + string(game.final_doko_items));
    draw_text(360, 680, "HP Remaining: " + string(game.final_hp));
    draw_text(360, 760, "Tap or Press R to Restart");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (game.game_state == "gameover") {
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(360, 460, "Game Over");
    draw_text(360, 530, "Delivery Failed");
    draw_text(360, 600, "Progress: " + string(game.final_progress_percent) + "%");
    draw_text(360, 660, "Points: " + string(game.final_points));
    draw_text(360, 740, "Tap or Press R to Restart");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}
