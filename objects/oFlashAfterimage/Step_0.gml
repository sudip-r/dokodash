var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state == "paused") {
        exit;
    }
}

life--;
alpha = max(0, life / 26 * 0.65);

if (life <= 0) {
    instance_destroy();
}
