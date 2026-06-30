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
    draw_text(32, 272, "Route: " + game.difficulty_name);

    if (game.slow_timer > 0) {
        draw_text(32, 312, "Slowed!");
    }

    if (instance_exists(player)) {
        var dash_ready = player.dash_cooldown <= 0;
        var dash_label = "DASH";

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        if (dash_ready) {
            draw_set_color(c_white);
        } else {
            draw_set_color(c_gray);
        }

        draw_rectangle(
            game.dash_button_x,
            game.dash_button_y,
            game.dash_button_x + game.dash_button_w,
            game.dash_button_y + game.dash_button_h,
            true
        );

        draw_text(
            game.dash_button_x + game.dash_button_w / 2,
            game.dash_button_y + 42,
            dash_label
        );

        if (!dash_ready) {
            var cooldown_percent = ceil((player.dash_cooldown / player.dash_cooldown_max) * 100);
            draw_text(
                game.dash_button_x + game.dash_button_w / 2,
                game.dash_button_y + 84,
                string(cooldown_percent) + "%"
            );
        } else {
            draw_text(
                game.dash_button_x + game.dash_button_w / 2,
                game.dash_button_y + 84,
                "Ready"
            );
        }

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
    }

    if (instance_exists(player)) {
        var flash_ready = player.flash_cooldown <= 0;

        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);

        if (flash_ready) {
            draw_set_color(c_white);
        } else {
            draw_set_color(c_gray);
        }

        draw_rectangle(
            game.flash_button_x,
            game.flash_button_y,
            game.flash_button_x + game.flash_button_w,
            game.flash_button_y + game.flash_button_h,
            true
        );

        draw_text(
            game.flash_button_x + game.flash_button_w / 2,
            game.flash_button_y + 42,
            "FLASH"
        );

        if (!flash_ready) {
            var cooldown_percent = ceil((player.flash_cooldown / player.flash_cooldown_max) * 100);
            draw_text(
                game.flash_button_x + game.flash_button_w / 2,
                game.flash_button_y + 84,
                string(cooldown_percent) + "%"
            );
        } else {
            draw_text(
                game.flash_button_x + game.flash_button_w / 2,
                game.flash_button_y + 84,
                "Ready"
            );
        }

        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
    }

    draw_text(32, 352, "Shift = Dash | F = Flash");

    draw_set_color(c_white);
    draw_rectangle(
        game.pause_button_x,
        game.pause_button_y,
        game.pause_button_x + game.pause_button_w,
        game.pause_button_y + game.pause_button_h,
        true
    );

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(
        game.pause_button_x + game.pause_button_w / 2,
        game.pause_button_y + game.pause_button_h / 2,
        "II"
    );

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

if (game.game_state == "paused") {
    draw_set_alpha(0.65);
    draw_set_color(c_black);
    draw_rectangle(0, 0, 720, 1280, false);
    draw_set_alpha(1);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_white);
    draw_text(360, 380, "Paused");

    // Resume button
    draw_rectangle(
        game.resume_button_x1,
        game.resume_button_y1,
        game.resume_button_x2,
        game.resume_button_y2,
        true
    );
    draw_text(360, 540, "Resume");

    // Restart button
    draw_rectangle(
        game.restart_button_x1,
        game.restart_button_y1,
        game.restart_button_x2,
        game.restart_button_y2,
        true
    );
    draw_text(360, 660, "Restart Mission");

    // Title button
    draw_rectangle(
        game.title_button_x1,
        game.title_button_y1,
        game.title_button_x2,
        game.title_button_y2,
        true
    );
    draw_text(360, 780, "Return to Title");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
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
