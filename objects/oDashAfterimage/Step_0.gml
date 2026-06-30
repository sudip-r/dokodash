var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state == "paused") {
        exit;
    }
}

life--;
alpha = max(0, life / 18 * 0.45);

if (life <= 0) {
    instance_destroy();
}
