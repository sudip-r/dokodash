var game = instance_find(oGame, 0);

if (!instance_exists(game)) {
    exit;
}

if (game.game_state != "playing") {
    exit;
}

decor_timer--;

if (decor_timer <= 0) {
    var side = choose("left", "right");
    var spawn_x;

    if (side == "left") {
        spawn_x = random_range(left_x_min, left_x_max);
    } else {
        spawn_x = random_range(right_x_min, right_x_max);
    }

    var decor_type = choose(
        oDecorTree,
        oDecorHouse,
        oDecorFence,
        oDecorBush,
        oDecorField
    );

    instance_create_layer(spawn_x, decor_y, "Instances", decor_type);

    decor_timer = decor_interval;
}
