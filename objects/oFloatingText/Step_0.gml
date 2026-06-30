var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state == "paused") {
        exit;
    }
}

y -= rise_speed;

life--;

if (life_max > 0) {
    text_alpha = clamp(life / life_max, 0, 1);
}

if (life <= 0) {
    instance_destroy();
}
