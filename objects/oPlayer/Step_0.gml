var game = instance_find(oGame, 0);

if (instance_exists(game)) {
    if (game.game_state != "playing") {
        exit;
    }

    path_left = game.path_left;
    path_right = game.path_right;
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

food_weight_level = food_carried;
doko_items = food_carried;

var food_move_penalty = min(food_carried * food_move_penalty_per_item, food_move_penalty_max);
var current_keyboard_move_speed = max(4, base_keyboard_move_speed - food_move_penalty);
var current_drag_smoothness = max(0.12, base_drag_move_smoothness - (food_carried * 0.01));

var extra_dash_cooldown = 0;

if (food_carried >= food_dash_penalty_threshold) {
    extra_dash_cooldown = min(
        (food_carried - food_dash_penalty_threshold + 1) * food_dash_cooldown_penalty_step,
        food_dash_cooldown_penalty_max
    );
}

var tap_pressed = device_mouse_check_button_pressed(0, mb_left);
var tap_down = device_mouse_check_button(0, mb_left);
var tap_released = device_mouse_check_button_released(0, mb_left);

var gui_x = device_mouse_x_to_gui(0);
var gui_y = device_mouse_y_to_gui(0);

var dash_pressed = keyboard_check_pressed(vk_shift);
var flash_pressed = keyboard_check_pressed(ord("F"));

var touching_dash_button = false;
var touching_flash_button = false;

if (instance_exists(game)) {
    touching_dash_button =
        gui_x >= game.dash_button_x &&
        gui_x <= game.dash_button_x + game.dash_button_w &&
        gui_y >= game.dash_button_y &&
        gui_y <= game.dash_button_y + game.dash_button_h;

    touching_flash_button =
        gui_x >= game.flash_button_x &&
        gui_x <= game.flash_button_x + game.flash_button_w &&
        gui_y >= game.flash_button_y &&
        gui_y <= game.flash_button_y + game.flash_button_h;
}

if (tap_pressed && touching_dash_button) {
    dash_pressed = true;
}

if (tap_pressed && touching_flash_button) {
    flash_pressed = true;
}

if (flash_pressed && flash_cooldown <= 0) {
    var flash_old_x = x;
    var flash_old_y = y;

    var flash_dir = last_move_direction;

    if (flash_dir == 0) {
        flash_dir = 1;
    }

    var flash_new_x = clamp(x + flash_dir * flash_distance, path_left, path_right);

    if (abs(flash_new_x - x) < 40) {
        flash_new_x = clamp(x - flash_dir * flash_distance, path_left, path_right);
    }

    if (flash_new_x != x) {
        var afterimage = instance_create_layer(flash_old_x, flash_old_y, "Instances", oFlashAfterimage);
        afterimage.source_sprite = sprite_index;
        afterimage.source_image_index = image_index;
        afterimage.source_xscale = image_xscale;
        afterimage.source_yscale = image_yscale;

        x = flash_new_x;
        target_x = x;

        flash_cooldown = flash_cooldown_max;
        flash_evade_timer = flash_evade_duration;

        var feedback = instance_create_layer(x, y - 56, "Instances", oFloatingText);
        feedback.display_text = "Flash Step!";
        feedback.text_color = c_fuchsia;
    }
}

if (dash_pressed && !flash_pressed && dash_cooldown <= 0 && !dash_active) {
    var dash_old_x = x;
    var dash_old_y = y;

    var dash_dir = last_move_direction;

    if (dash_dir == 0) {
        dash_dir = 1;
    }

    var dash_new_x = clamp(x + dash_dir * dash_distance, path_left, path_right);

    if (dash_new_x != x) {
        x = dash_new_x;
        target_x = x;

        dash_active = true;
        dash_timer = dash_duration;
        dash_cooldown = dash_cooldown_max + extra_dash_cooldown;
        dash_enemy_evade_timer = dash_enemy_evade_duration;

        var feedback = instance_create_layer(x, y - 56, "Instances", oFloatingText);
        feedback.display_text = "Dash!";
        feedback.text_color = c_aqua;

        var afterimage = instance_create_layer(dash_old_x, dash_old_y, "Instances", oDashAfterimage);
        afterimage.source_sprite = sprite_index;
        afterimage.source_image_index = image_index;
        afterimage.source_xscale = image_xscale;
        afterimage.source_yscale = image_yscale;
    }
}

var input_x = 0;

if (keyboard_check(vk_left) || keyboard_check(ord("A"))) {
    input_x -= 1;
}

if (keyboard_check(vk_right) || keyboard_check(ord("D"))) {
    input_x += 1;
}

if (input_x != 0) {
    x += input_x * current_keyboard_move_speed;
    last_move_direction = sign(input_x);
    target_x = x;
}

var tried_left_border = false;
var tried_right_border = false;

if (x <= path_left + 2 && input_x < 0) {
    tried_left_border = true;
}

if (x >= path_right - 2 && input_x > 0) {
    tried_right_border = true;
}

if (tap_down && movement_touch_active) {
    if (x <= path_left + 2 && gui_x < path_left) {
        tried_left_border = true;
    }

    if (x >= path_right - 2 && gui_x > path_right) {
        tried_right_border = true;
    }
}

if (border_feedback_timer > 0) {
    border_feedback_timer--;
}

if ((tried_left_border || tried_right_border) && border_feedback_timer <= 0) {
    var border_feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
    border_feedback.display_text = "Dense Forest";
    border_feedback.text_color = c_gray;
    border_feedback.life = 35;
    border_feedback.life_max = border_feedback.life;

    border_feedback_timer = border_feedback_cooldown;
}

if (tap_pressed && !touching_dash_button && !touching_flash_button) {
    movement_touch_active = true;
    target_x = clamp(gui_x, path_left, path_right);
}

if (tap_down && movement_touch_active) {
    var previous_target_x = target_x;
    target_x = clamp(gui_x, path_left, path_right);

    if (target_x > previous_target_x) {
        last_move_direction = 1;
    } else if (target_x < previous_target_x) {
        last_move_direction = -1;
    }
}

if (tap_released) {
    movement_touch_active = false;
}

if (movement_touch_active) {
    x = lerp(x, target_x, current_drag_smoothness);
}

x = clamp(x, path_left, path_right);
y = player_y_fixed;
