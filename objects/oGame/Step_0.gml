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

if (slow_timer > 0) {
    slow_timer--;
    game_speed = slow_game_speed;
} else {
    game_speed = base_game_speed;
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
        var obstacle_type = choose(oStone, oGoat, oBasket, oChicken, oPuddle);

        instance_create_layer(spawn_x, -80, "Instances", obstacle_type);

        // Remove lane so nothing else spawns on top of this obstacle.
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
if (distance >= finish_distance) {
    game_state = "complete";
}
