var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state != "playing") {
        exit;
    }
}

if (hit_cooldown > 0) {
    hit_cooldown--;
}

if (dash_cooldown > 0) {
    dash_cooldown--;
}

if (dash_timer > 0) {
    dash_timer--;

    if (dash_timer <= 0) {
        dash_active = false;
    }
}

if (dash_enemy_evade_timer > 0) {
    dash_enemy_evade_timer--;
}

if (flash_cooldown > 0) {
    flash_cooldown--;
}

if (flash_evade_timer > 0) {
    flash_evade_timer--;
}

var dash_pressed = keyboard_check_pressed(vk_shift);
var flash_pressed = keyboard_check_pressed(ord("F"));
var dash_touch_pressed = false;
var flash_touch_pressed = false;

if (instance_exists(game)) {
    var tap_pressed = device_mouse_check_button_pressed(0, mb_left);
    var gui_x = device_mouse_x_to_gui(0);
    var gui_y = device_mouse_y_to_gui(0);

    var tapped_dash_button =
        tap_pressed &&
        gui_x >= game.dash_button_x &&
        gui_x <= game.dash_button_x + game.dash_button_w &&
        gui_y >= game.dash_button_y &&
        gui_y <= game.dash_button_y + game.dash_button_h;

    var tapped_flash_button =
        tap_pressed &&
        gui_x >= game.flash_button_x &&
        gui_x <= game.flash_button_x + game.flash_button_w &&
        gui_y >= game.flash_button_y &&
        gui_y <= game.flash_button_y + game.flash_button_h;

    if (tapped_dash_button) {
        dash_pressed = true;
        dash_touch_pressed = true;
    }

    if (tapped_flash_button) {
        flash_pressed = true;
        flash_touch_pressed = true;
    }
}

if (flash_pressed && flash_cooldown <= 0) {
    var old_x = x;
    var old_y = y;

    var new_lane = lane + (last_lane_direction * flash_distance_lanes);

    if (new_lane < 0 || new_lane > 2) {
        new_lane = lane - (last_lane_direction * flash_distance_lanes);
    }

    new_lane = clamp(new_lane, 0, 2);

    if (new_lane != lane) {
        var afterimage = instance_create_layer(old_x, old_y, "Instances", oFlashAfterimage);
        afterimage.source_sprite = sprite_index;
        afterimage.source_image_index = image_index;
        afterimage.source_xscale = image_xscale;
        afterimage.source_yscale = image_yscale;

        lane = new_lane;
        target_x = lane_x[lane];
        x = target_x;

        flash_cooldown = flash_cooldown_max;
        flash_evade_timer = flash_evade_duration;

        var feedback = instance_create_layer(x, y - 56, "Instances", oFloatingText);
        feedback.display_text = "Flash Step!";
        feedback.text_color = c_fuchsia;
    }
}

if (dash_pressed && !flash_pressed && dash_cooldown <= 0 && !dash_active) {
    var new_lane = lane + last_lane_direction;

    if (new_lane < 0 || new_lane > 2) {
        new_lane = lane - last_lane_direction;
    }

    new_lane = clamp(new_lane, 0, 2);

    if (new_lane != lane) {
        lane = new_lane;

        dash_active = true;
        dash_timer = dash_duration;
        dash_cooldown = dash_cooldown_max;
        dash_enemy_evade_timer = dash_enemy_evade_duration;

        var feedback = instance_create_layer(x, y - 56, "Instances", oFloatingText);
        feedback.display_text = "Dash!";
        feedback.text_color = c_aqua;

        var afterimage = instance_create_layer(x, y, "Instances", oDashAfterimage);
        afterimage.source_sprite = sprite_index;
        afterimage.source_image_index = image_index;
        afterimage.source_xscale = image_xscale;
        afterimage.source_yscale = image_yscale;
    }
}

// -------------------------
// Keyboard test controls
// -------------------------
if (keyboard_check_pressed(vk_left)) {
    lane = max(0, lane - 1);
    last_lane_direction = -1;
}

if (keyboard_check_pressed(vk_right)) {
    lane = min(2, lane + 1);
    last_lane_direction = 1;
}

// -------------------------
// Mouse/touch swipe controls
// This works for desktop mouse testing too.
// -------------------------
if (device_mouse_check_button_pressed(0, mb_left) && !dash_touch_pressed && !flash_touch_pressed) {
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
            last_lane_direction = -1;
        } else {
            lane = min(2, lane + 1);
            last_lane_direction = 1;
        }
    }

    touch_active = false;
}

// -------------------------
// Smooth movement to lane
// -------------------------
target_x = lane_x[lane];

if (dash_active) {
    x = lerp(x, target_x, dash_move_smoothness);
} else {
    x = lerp(x, target_x, normal_move_smoothness);
}

// Keep player fixed vertically for now
y = 980;
