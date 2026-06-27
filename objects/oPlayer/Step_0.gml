var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state != "playing") {
        exit;
    }
}

// -------------------------
// Keyboard test controls
// -------------------------
if (keyboard_check_pressed(vk_left)) {
    lane = max(0, lane - 1);
}

if (keyboard_check_pressed(vk_right)) {
    lane = min(2, lane + 1);
}

// -------------------------
// Mouse/touch swipe controls
// This works for desktop mouse testing too.
// -------------------------
if (device_mouse_check_button_pressed(0, mb_left)) {
    touch_start_x = device_mouse_x_to_gui(0);
    touch_start_y = device_mouse_y_to_gui(0);
    touch_active = true;
}

if (device_mouse_check_button_released(0, mb_left) && touch_active) {
    var end_x = device_mouse_x_to_gui(0);
    var end_y = device_mouse_y_to_gui(0);

    var dx = end_x - touch_start_x;
    var dy = end_y - touch_start_y;

    if (abs(dx) > abs(dy) && abs(dx) > swipe_threshold) {
        if (dx < 0) {
            lane = max(0, lane - 1);
        } else {
            lane = min(2, lane + 1);
        }
    }

    touch_active = false;
}

// -------------------------
// Smooth movement to lane
// -------------------------
target_x = lane_x[lane];
x = lerp(x, target_x, move_smoothness);

// Keep player fixed vertically for now
y = 980;
