var game = instance_find(oGame, 0);

if (!instance_exists(game)) {
    exit;
}

if (game.game_state != "playing") {
    exit;
}

steer_strength = game.chaser_steer_strength;
max_steer_speed = game.chaser_max_steer_speed;

y += game.game_speed;

var player = instance_find(oPlayer, 0);

if (instance_exists(player)) {
    var desired_x = clamp(player.x, game.path_left, game.path_right);
    var dx = desired_x - x;

    var steer = clamp(dx * steer_strength, -max_steer_speed, max_steer_speed);
    x += steer;

    x = clamp(x, game.path_left, game.path_right);

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
                var player_game = instance_find(oGame, 0);

                player_hp -= other.enemy_damage;
                hit_cooldown = hit_cooldown_max;

                if (instance_exists(player_game)) {
                    player_game.damage_flash_timer = player_game.damage_flash_duration;
                }

                var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
                feedback.display_text = "Caught!";
                feedback.text_color = c_red;
                feedback.life = 45;
                feedback.life_max = feedback.life;

                if (player_hp <= 0) {
                    if (instance_exists(player_game)) {
                        if (!player_game.result_recorded) {
                            player_game.result_recorded = true;

                            var progress = clamp(player_game.distance / player_game.finish_distance, 0, 1);
                            player_game.final_progress_percent = floor(progress * 100);

                            player_game.final_points = points;
                            player_game.final_food_carried = food_carried;
                            player_game.villagers_fed = 0;
                            player_game.final_doko_items = food_carried;
                            player_game.final_hp = player_hp;
                            player_game.star_count = 0;
                        }

                        player_game.game_state = "gameover";
                    }
                }
            }
        }

        instance_destroy();
        exit;
    }
}

if (y > room_height + 120) {
    instance_destroy();
}
