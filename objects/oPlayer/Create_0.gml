// Compatibility only. Player movement is no longer lane-locked.
lane = 1;
lane_x = [180, 360, 540];

// Free horizontal movement
path_left = 140;
path_right = 580;

target_x = x;
player_y_fixed = 980;

move_speed = 8;
keyboard_move_speed = 9;
drag_move_smoothness = 0.22;

last_move_direction = 1; // 1 = right, -1 = left

// Touch/drag movement
movement_touch_active = false;
movement_touch_id = 0;

border_feedback_timer = 0;
border_feedback_cooldown = 30;

debug_hitbox_w = 36;
debug_hitbox_h = 56;

player_hp = 3;
points = 0;
doko_items = 0;

// Food load / risk-reward system
food_carried = 0;
food_weight_level = 0;

base_keyboard_move_speed = keyboard_move_speed;
base_drag_move_smoothness = drag_move_smoothness;

food_move_penalty_per_item = 0.25;
food_move_penalty_max = 2;

food_dash_penalty_threshold = 4;
food_dash_cooldown_penalty_step = 15;
food_dash_cooldown_penalty_max = 45;

hit_cooldown = 0;
hit_cooldown_max = 45;

// Dash skill
dash_active = false;
dash_timer = 0;
dash_duration = 12;
dash_distance = 110;

dash_cooldown = 0;
dash_cooldown_max = 150; // around 2.5 seconds at 60 FPS

dash_enemy_evade_timer = 0;
dash_enemy_evade_duration = 15;

// Flash Step skill
flash_distance = 260;
flash_cooldown = 0;
flash_cooldown_max = 600; // around 10 seconds at 60 FPS

flash_evade_timer = 0;
flash_evade_duration = 22;
