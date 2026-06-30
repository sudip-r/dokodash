var game = instance_find(oGame, 0);

if (!instance_exists(game)) {
    exit;
}

if (game.game_state != "playing") {
    exit;
}

y += game.game_speed;

warning_timer--;
blink_timer++;

if (warning_timer <= 0) {
    var enemy = instance_create_layer(lane_x[lane], y, "Instances", target_enemy);
    enemy.lane = lane;
    enemy.target_lane = lane;
    enemy.x = lane_x[lane];

    instance_destroy();
}

if (y > room_height + 120) {
    instance_destroy();
}
