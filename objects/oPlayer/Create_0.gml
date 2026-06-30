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

player_hp = 3;
points = 0;
doko_items = 0;

hit_cooldown = 0;
hit_cooldown_max = 45;

// Dash skill
dash_active = false;
dash_timer = 0;
dash_duration = 12;
dash_distance = 120;

dash_cooldown = 0;
dash_cooldown_max = 150; // around 2.5 seconds at 60 FPS

dash_enemy_evade_timer = 0;
dash_enemy_evade_duration = 15;

// Flash Step skill
flash_distance = 240;
flash_cooldown = 0;
flash_cooldown_max = 600; // around 10 seconds at 60 FPS

flash_evade_timer = 0;
flash_evade_duration = 22;
