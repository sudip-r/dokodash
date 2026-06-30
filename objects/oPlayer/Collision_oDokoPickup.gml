points += 5;
food_carried += 1;
doko_items = food_carried;

var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
feedback.display_text = "+1 Food";
feedback.text_color = c_lime;
feedback.life = 45;
feedback.life_max = feedback.life;

instance_destroy(other);
