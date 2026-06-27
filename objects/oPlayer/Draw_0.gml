if (hit_cooldown > 0) {
    if ((hit_cooldown div 5) mod 2 == 0) {
        draw_self();
    }
} else {
    draw_self();
}
