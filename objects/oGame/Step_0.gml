if (game_state != "playing") {
    exit;
}

// Route progress
distance += game_speed;

// Spawn obstacles
spawn_timer--;

if (spawn_timer <= 0) {
    var lane_index = irandom(2);
    var spawn_x = lanes[lane_index];

    var obstacle_type = choose(oStone, oGoat);
    instance_create_layer(spawn_x, -80, "Instances", obstacle_type);

    spawn_timer = spawn_interval;
}

// Spawn coins
coin_timer--;

if (coin_timer <= 0) {
    var lane_index = irandom(2);
    var spawn_x = lanes[lane_index];

    instance_create_layer(spawn_x, -80, "Instances", oCoin);

    coin_timer = coin_interval;
}

// Finish condition
if (distance >= finish_distance) {
    game_state = "complete";
}
