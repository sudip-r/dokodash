var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state != "playing") {
        exit;
    }

    y += game.game_speed;
}

if (y > room_height + 100) {
    instance_destroy();
}
