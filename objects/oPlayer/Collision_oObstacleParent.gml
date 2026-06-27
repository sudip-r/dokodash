if (other.object_index == oPuddle) {
    var game = instance_find(oGame, 0);

    if (instance_exists(game)) {
        game.slow_timer = game.slow_duration;
    }

    var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
    feedback.display_text = "Slowed!";
    feedback.text_color = c_aqua;

    instance_destroy(other);
    exit;
}

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
