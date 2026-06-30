if (flash_evade_timer > 0) {
    var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
    feedback.display_text = "Phased!";
    feedback.text_color = c_fuchsia;

    instance_destroy(other);
    exit;
}

if (other.object_index == oPuddle) {
    var game = instance_find(oGame, 0);

    if (instance_exists(game)) {
        game.slow_timer = game.slow_duration;
    }

    var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
    feedback.display_text = "Slowed!";
    feedback.text_color = c_aqua;

    instance_destroy(other);
    exit;
}

if (hit_cooldown <= 0) {
    var game = instance_find(oGame, 0);

    player_hp -= other.damage;
    hit_cooldown = hit_cooldown_max;

    if (instance_exists(game)) {
        game.damage_flash_timer = game.damage_flash_duration;
    }

    var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
    feedback.display_text = "Hit!";
    feedback.text_color = c_red;
    feedback.life = 40;
    feedback.life_max = feedback.life;

    if (player_hp <= 0) {
        if (instance_exists(game)) {
            if (!game.result_recorded) {
                game.result_recorded = true;

                var progress = clamp(game.distance / game.finish_distance, 0, 1);
                game.final_progress_percent = floor(progress * 100);

                game.final_points = points;
                game.final_doko_items = doko_items;
                game.final_hp = player_hp;
                game.star_count = 0;
            }

            game.game_state = "gameover";
        }
    }
}

instance_destroy(other);
