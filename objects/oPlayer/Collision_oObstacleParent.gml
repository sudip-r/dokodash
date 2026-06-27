if (hit_cooldown <= 0) {
    player_hp -= other.damage;
    hit_cooldown = hit_cooldown_max;

    if (player_hp <= 0) {
        var game = instance_find(oGame, 0);

        if (instance_exists(game)) {
            game.game_state = "gameover";
        }
    }
}

instance_destroy(other);
