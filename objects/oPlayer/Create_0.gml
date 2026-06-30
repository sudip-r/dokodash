lane = 1; // 0 = left, 1 = middle, 2 = right
lane_x = [180, 360, 540];

target_x = lane_x[lane];

move_smoothness = 0.25;
normal_move_smoothness = move_smoothness;

player_hp = 3;
points = 0;
doko_items = 0;

hit_cooldown = 0;
hit_cooldown_max = 45;

// Dash skill
dash_active = false;
dash_timer = 0;
dash_duration = 12;

dash_cooldown = 0;
dash_cooldown_max = 150; // around 2.5 seconds at 60 FPS

dash_move_smoothness = 0.65;

dash_enemy_evade_timer = 0;
dash_enemy_evade_duration = 15;

last_lane_direction = 1; // 1 = right, -1 = left

// Flash Step skill
flash_cooldown = 0;
flash_cooldown_max = 600; // around 10 seconds at 60 FPS

flash_evade_timer = 0;
flash_evade_duration = 22;

flash_distance_lanes = 2;

// Touch/swipe tracking
touch_start_x = 0;
touch_start_y = 0;
touch_active = false;
swipe_threshold = 60;
