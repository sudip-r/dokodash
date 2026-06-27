if (hit_cooldown > 0) {
    instance_destroy(other);
    exit;
}

player_hp -= other.damage;
hit_cooldown = hit_cooldown_max;

instance_destroy(other);

if (player_hp <= 0) {
    var game = instance_find(oGame, 0);

    if (instance_exists(game)) {
        game.game_state = "gameover";
    }
}
