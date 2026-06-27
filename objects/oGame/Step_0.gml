if (game_state == "gameover" || game_state == "complete") {
    if (keyboard_check_pressed(ord("R"))) {
        room_restart();
    }

    if (device_mouse_check_button_pressed(0, mb_left)) {
        room_restart();
    }

    exit;
}

if (game_state != "playing") {
    exit;
}

// Route progress
distance += game_speed;

spawn_timer--;

if (spawn_timer <= 0) {
    // Start with all lanes available
    var available_lanes = [0, 1, 2];

    // Spawn 1 or 2 obstacles, never 3
    var obstacle_count = choose(1, 1, 2);

    repeat (obstacle_count) {
        var pick_index = irandom(array_length(available_lanes) - 1);
        var lane_index = available_lanes[pick_index];

        var spawn_x = lanes[lane_index];
        var obstacle_type = choose(oStone, oGoat);

        instance_create_layer(spawn_x, -80, "Instances", obstacle_type);

        // Remove this lane from available lanes,
        // so coins cannot spawn on top of this obstacle.
        array_delete(available_lanes, pick_index, 1);
    }

    // Coins can only spawn in remaining safe lanes
    if (array_length(available_lanes) > 0) {
        if (random(1) < coin_chance) {
            var coin_pick_index = irandom(array_length(available_lanes) - 1);
            var coin_lane_index = available_lanes[coin_pick_index];

            var coin_x = lanes[coin_lane_index];

            instance_create_layer(coin_x, -80, "Instances", oCoin);
        }
    }

    spawn_timer = spawn_interval;
}

// Finish condition
if (distance >= finish_distance) {
    game_state = "complete";
}
