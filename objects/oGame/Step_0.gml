if (game_state != "playing") {
    if (keyboard_check_pressed(ord("R")) || device_mouse_check_button_pressed(0, mb_left)) {
        room_restart();
    }

    exit;
}

// Route progress
distance += game_speed;

// Spawn obstacles
spawn_timer--;

if (spawn_timer <= 0) {
    var lane_index = irandom(2);

    if (lane_index == last_obstacle_lane) {
        lane_index = (lane_index + 1 + irandom(1)) mod 3;
    }

    var spawn_x = lanes[lane_index];

    var obstacle_type = choose(oStone, oGoat);
    instance_create_layer(spawn_x, -80, "Instances", obstacle_type);

    last_obstacle_lane = lane_index;
    spawn_timer = spawn_interval;
}

// Spawn coins
coin_timer--;

if (coin_timer <= 0) {
    var lane_index = irandom(2);

    var lane_attempts = 0;
    while ((lane_index == last_obstacle_lane || lane_index == last_coin_lane) && lane_attempts < 3) {
        lane_index = (lane_index + 1) mod 3;
        lane_attempts++;
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
