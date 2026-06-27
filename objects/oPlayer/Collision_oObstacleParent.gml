player_hp -= other.damage;
instance_destroy(other);

if (player_hp <= 0) {
    var game = instance_find(oGame, 0);

    if (instance_exists(game)) {
        game.game_state = "gameover";
    }
}
