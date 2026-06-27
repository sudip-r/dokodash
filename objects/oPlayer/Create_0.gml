lane = 1; // 0 = left, 1 = middle, 2 = right
lane_x = [180, 360, 540];

target_x = lane_x[lane];

move_smoothness = 0.25;

player_hp = 3;
points = 0;

// Touch/swipe tracking
touch_start_x = 0;
touch_start_y = 0;
touch_active = false;
swipe_threshold = 60;
