display_set_gui_size(720, 1280);

difficulty_stage = 1;
difficulty_name = "Quiet Path";

difficulty_progress = 0;

// Base tuning values
base_spawn_interval = 60;
base_coin_chance = 0.60;
base_doko_pickup_chance = 0.18;
base_enemy_warning_chance = 0.15;
base_game_speed = 6;

// Dynamic values used during gameplay
game_speed = base_game_speed;
spawn_interval = base_spawn_interval;
coin_chance = base_coin_chance;
doko_pickup_chance = base_doko_pickup_chance;
enemy_warning_chance = base_enemy_warning_chance;

// Obstacle row tuning
min_obstacles_per_row = 1;
max_obstacles_per_row = 1;

// Final stretch flag
final_stretch_started = false;

slow_timer = 0;
slow_duration = 45;
slow_game_speed = 3;

distance = 0;
finish_distance = 36000;

spawn_timer = 60;

lanes = [180, 360, 540];

max_active_chasers = 1;

mission_name = "Night Food Run";
mission_goal_text = "Bring food from the hidden farm without getting caught";

star_count = 0;
final_points = 0;
final_doko_items = 0;
final_hp = 0;
final_progress_percent = 0;

result_recorded = false;

// Pause button
pause_button_x = 620;
pause_button_y = 32;
pause_button_w = 68;
pause_button_h = 68;

// Pause menu buttons
resume_button_x1 = 220;
resume_button_y1 = 500;
resume_button_x2 = 500;
resume_button_y2 = 580;

restart_button_x1 = 220;
restart_button_y1 = 620;
restart_button_x2 = 500;
restart_button_y2 = 700;

title_button_x1 = 220;
title_button_y1 = 740;
title_button_x2 = 500;
title_button_y2 = 820;

// Dash button position for mobile-style control
dash_button_x = 44;
dash_button_y = 1080;
dash_button_w = 180;
dash_button_h = 120;

// Flash Step button position for mobile-style control
flash_button_x = 496;
flash_button_y = 1080;
flash_button_w = 180;
flash_button_h = 120;

game_state = "playing";
