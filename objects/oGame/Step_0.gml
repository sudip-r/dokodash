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

// Spawn obstacles
spawn_timer--;

if (spawn_timer <= 0) {
    var obstacle_count = choose(1, 1, 2);
    var available_lanes = [0, 1, 2];

    repeat (obstacle_count) {
        var pick_index = irandom(array_length(available_lanes) - 1);
        var lane_index = available_lanes[pick_index];

        var spawn_x = lanes[lane_index];
        var obstacle_type = choose(oStone, oGoat);

        instance_create_layer(spawn_x, -80, "Instances", obstacle_type);
        array_delete(available_lanes, pick_index, 1);
    }

    spawn_timer = spawn_interval;
}

// Spawn coins
coin_timer--;

if (coin_timer <= 0) {
    var lane_index = irandom(2);

    if (lane_index == last_coin_lane) {
        lane_index = (lane_index + 1) mod 3;
    }

    var spawn_x = lanes[lane_index];

    instance_create_layer(spawn_x, -80, "Instances", oCoin);

    last_coin_lane = lane_index;
    coin_timer = coin_interval;
}

// Finish condition
if (distance >= finish_distance) {
    game_state = "complete";
}
