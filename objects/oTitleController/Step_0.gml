if (input_cooldown > 0) {
    input_cooldown--;
}

var pressed = false;

if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_space)) {
    pressed = true;
}

if (device_mouse_check_button_pressed(0, mb_left)) {
    pressed = true;
}

if (input_cooldown <= 0 && pressed) {
    if (screen_state == "title") {
        screen_state = "story";
        input_cooldown = 10;
    } else if (screen_state == "story") {
        story_index++;

        if (story_index >= array_length(story_lines)) {
            room_goto(rm_game);
        } else {
            input_cooldown = 10;
        }
    }
}
