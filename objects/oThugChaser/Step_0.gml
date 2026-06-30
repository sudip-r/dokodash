var game = instance_find(oGame, 0);

if (!instance_exists(game)) {
    exit;
}

if (game.game_state != "playing") {
    exit;
}

y += game.game_speed;

var player = instance_find(oPlayer, 0);

if (instance_exists(player)) {
    change_lane_timer--;

    if (change_lane_timer <= 0) {
        if (player.lane < lane) {
            lane = max(0, lane - 1);
        } else if (player.lane > lane) {
            lane = min(2, lane + 1);
        }

        target_lane = lane;
        change_lane_timer = change_lane_interval;
    }

    if (abs(player.x - x) < 48 && abs(player.y - y) < 72) {
        with (player) {
            if (flash_evade_timer > 0) {
                var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
                feedback.display_text = "Vanished!";
                feedback.text_color = c_fuchsia;
            } else if (dash_enemy_evade_timer > 0) {
                var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
                feedback.display_text = "Evaded!";
                feedback.text_color = c_aqua;
            } else if (hit_cooldown <= 0) {
                var game = instance_find(oGame, 0);

                player_hp -= other.enemy_damage;
                hit_cooldown = hit_cooldown_max;

                if (instance_exists(game)) {
                    game.damage_flash_timer = game.damage_flash_duration;
                }

                var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
                feedback.display_text = "Caught!";
                feedback.text_color = c_red;
                feedback.life = 45;
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
        }

        instance_destroy();
        exit;
    }
}

x = lerp(x, lane_x[target_lane], move_smoothness);

if (y > room_height + 120) {
    instance_destroy();
}
