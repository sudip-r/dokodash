var game = instance_find(oGame, 0);

if (!instance_exists(game)) {
    exit;
}

if (game.game_state != "playing") {
    exit;
}

// Reduce visual clutter during enemy warning/chaser moments.
if (instance_number(oEnemyWarning) > 0 || instance_number(oThugChaser) > 0) {
    decor_timer = max(decor_timer, 20);
    exit;
}

// Do not allow too many decorations on screen.
if (instance_number(oDecorParent) >= max_active_decor) {
    exit;
}

decor_timer--;

if (decor_timer <= 0) {
    var side = next_side;

    // Alternate side most of the time.
    if (next_side == "left") {
        next_side = "right";
    } else {
        next_side = "left";
    }

    var decor_type;

    // Small objects appear more often, large objects less often.
    if (random(1) < large_decor_chance) {
        decor_type = choose(oDecorHouse, oDecorField);
    } else {
        decor_type = choose(oDecorTree, oDecorFence, oDecorBush, oDecorBush);
    }

    var decor = instance_create_layer(0, decor_y, "Instances", decor_type);

    if (decor_type == oDecorHouse || decor_type == oDecorField) {
        decor.image_xscale = 0.60;
        decor.image_yscale = 0.60;
    }

    var half_w = 32;

    if (decor.sprite_index != -1) {
        half_w = (sprite_get_width(decor.sprite_index) * abs(decor.image_xscale)) / 2;
    }

    if (side == "left") {
        var left_min = -half_w * 0.25;
        var left_max = road_left - road_margin - half_w;

        if (left_max < left_min) {
            left_max = left_min;
        }

        decor.x = random_range(left_min, left_max);
    } else {
        var right_min = road_right + road_margin + half_w;
        var right_max = room_width + half_w * 0.25;

        if (right_max < right_min) {
            right_max = right_min;
        }

        decor.x = random_range(right_min, right_max);
    }

    decor.y = decor_y;

    decor_timer = decor_interval;
}
