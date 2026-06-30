var tap_pressed = device_mouse_check_button_pressed(0, mb_left);
var gui_x = device_mouse_x_to_gui(0);
var gui_y = device_mouse_y_to_gui(0);

var pause_pressed = keyboard_check_pressed(ord("P")) || keyboard_check_pressed(vk_escape);

if (game_state == "playing") {
    var tapped_pause_button =
        tap_pressed &&
        gui_x >= pause_button_x &&
        gui_x <= pause_button_x + pause_button_w &&
        gui_y >= pause_button_y &&
        gui_y <= pause_button_y + pause_button_h;

    if (pause_pressed || tapped_pause_button) {
        game_state = "paused";
        exit;
    }
}

if (game_state == "paused") {
    if (pause_pressed) {
        game_state = "playing";
        exit;
    }

    if (tap_pressed) {
        var tapped_resume =
            gui_x >= resume_button_x1 &&
            gui_x <= resume_button_x2 &&
            gui_y >= resume_button_y1 &&
            gui_y <= resume_button_y2;

        var tapped_restart =
            gui_x >= restart_button_x1 &&
            gui_x <= restart_button_x2 &&
            gui_y >= restart_button_y1 &&
            gui_y <= restart_button_y2;

        var tapped_title =
            gui_x >= title_button_x1 &&
            gui_x <= title_button_x2 &&
            gui_y >= title_button_y1 &&
            gui_y <= title_button_y2;

        if (tapped_resume) {
            game_state = "playing";
            exit;
        }

        if (tapped_restart) {
            room_restart();
            exit;
        }

        if (tapped_title) {
            room_goto(rm_title);
            exit;
        }
    }

    exit;
}

if (game_state == "gameover" || game_state == "complete") {
    if (keyboard_check_pressed(ord("R"))) {
        room_restart();
    }

    if (tap_pressed) {
        room_restart();
    }

    exit;
}

if (game_state != "playing") {
    exit;
}

if (slow_timer > 0) {
    slow_timer--;
    game_speed = slow_game_speed;
} else {
    game_speed = base_game_speed;
}

// Route progress
distance += game_speed;

difficulty_progress = clamp(distance / finish_distance, 0, 1);

var previous_stage = difficulty_stage;

// Stage 1: 0% to 25%
if (difficulty_progress < 0.25) {
    difficulty_stage = 1;
    difficulty_name = "Quiet Path";

    spawn_interval = 65;
    enemy_warning_chance = 0.08;
    coin_chance = 0.65;
    doko_pickup_chance = 0.20;

    min_obstacles_per_row = 1;
    max_obstacles_per_row = 1;
}

// Stage 2: 25% to 50%
else if (difficulty_progress < 0.50) {
    difficulty_stage = 2;
    difficulty_name = "Patrol Roads";

    spawn_interval = 58;
    enemy_warning_chance = 0.16;
    coin_chance = 0.60;
    doko_pickup_chance = 0.18;

    min_obstacles_per_row = 1;
    max_obstacles_per_row = 2;
}

// Stage 3: 50% to 75%
else if (difficulty_progress < 0.75) {
    difficulty_stage = 3;
    difficulty_name = "Dark Crossing";

    spawn_interval = 50;
    enemy_warning_chance = 0.24;
    coin_chance = 0.55;
    doko_pickup_chance = 0.16;

    min_obstacles_per_row = 1;
    max_obstacles_per_row = 2;
}

// Stage 4: 75% to 100%
else {
    difficulty_stage = 4;
    difficulty_name = "Final Stretch";

    spawn_interval = 44;
    enemy_warning_chance = 0.32;
    coin_chance = 0.50;
    doko_pickup_chance = 0.14;

    min_obstacles_per_row = 1;
    max_obstacles_per_row = 2;

    if (!final_stretch_started) {
        final_stretch_started = true;

        var feedback = instance_create_layer(room_width / 2, 360, "Instances", oFloatingText);
        feedback.display_text = "Final Stretch!";
        feedback.text_color = c_red;
        feedback.life = 90;
    }
}

if (difficulty_stage != previous_stage) {
    var feedback = instance_create_layer(room_width / 2, 420, "Instances", oFloatingText);
    feedback.display_text = difficulty_name;
    feedback.text_color = c_yellow;
    feedback.life = 90;
}

spawn_timer--;

if (spawn_timer <= 0) {
    // Start with all lanes available
    var available_lanes = [0, 1, 2];

    // Optional enemy warning spawn
    if (instance_number(oThugChaser) < max_active_chasers && instance_number(oEnemyWarning) <= 0) {
        if (random(1) < enemy_warning_chance) {
            var enemy_pick_index = irandom(array_length(available_lanes) - 1);
            var enemy_lane_index = available_lanes[enemy_pick_index];
            var enemy_x = lanes[enemy_lane_index];

            var warning = instance_create_layer(enemy_x, -80, "Instances", oEnemyWarning);
            warning.lane = enemy_lane_index;
            warning.x = enemy_x;

            array_delete(available_lanes, enemy_pick_index, 1);
        }
    }

    var safe_lane_reserve = 1;
    var possible_obstacles = max(0, array_length(available_lanes) - safe_lane_reserve);

    var obstacle_limit = min(max_obstacles_per_row, possible_obstacles);
    var obstacle_count = 0;

    if (obstacle_limit > 0) {
        var obstacle_min = min(min_obstacles_per_row, obstacle_limit);
        obstacle_count = irandom_range(obstacle_min, obstacle_limit);
    }

    repeat (obstacle_count) {
        var pick_index = irandom(array_length(available_lanes) - 1);
        var lane_index = available_lanes[pick_index];

        var spawn_x = lanes[lane_index];
        var obstacle_roll = random(1);
        var obstacle_type;

        if (difficulty_stage >= 3 && obstacle_roll < 0.25) {
            obstacle_type = oPuddle;
        } else {
            obstacle_type = choose(oStone, oGoat, oBasket, oChicken, oPuddle);
        }

        instance_create_layer(spawn_x, -80, "Instances", obstacle_type);

        array_delete(available_lanes, pick_index, 1);
    }

    // Spawn either a special doko pickup or a coin in remaining safe lanes.
    if (array_length(available_lanes) > 0) {
        var collectible_roll = random(1);

        if (collectible_roll < doko_pickup_chance) {
            var doko_pick_index = irandom(array_length(available_lanes) - 1);
            var doko_lane_index = available_lanes[doko_pick_index];
            var doko_x = lanes[doko_lane_index];

            instance_create_layer(doko_x, -80, "Instances", oDokoPickup);

            array_delete(available_lanes, doko_pick_index, 1);
        } else if (collectible_roll < doko_pickup_chance + coin_chance) {
            var coin_pick_index = irandom(array_length(available_lanes) - 1);
            var coin_lane_index = available_lanes[coin_pick_index];
            var coin_x = lanes[coin_lane_index];

            instance_create_layer(coin_x, -80, "Instances", oCoin);
        }
    }

    spawn_timer = spawn_interval;
}

// Finish condition
if (distance >= finish_distance && !result_recorded) {
    var player = instance_find(oPlayer, 0);

    result_recorded = true;
    game_state = "complete";

    final_progress_percent = 100;

    if (instance_exists(player)) {
        final_points = player.points;
        final_doko_items = player.doko_items;
        final_hp = player.player_hp;

        star_count = 1;

        if (player.player_hp >= 2) {
            star_count += 1;
        }

        if (player.doko_items >= 2) {
            star_count += 1;
        }
    } else {
        final_points = 0;
        final_doko_items = 0;
        final_hp = 0;
        star_count = 1;
    }
}
