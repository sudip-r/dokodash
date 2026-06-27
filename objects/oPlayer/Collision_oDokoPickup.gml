points += 5;
doko_items += 1;

var feedback = instance_create_layer(x, y - 48, "Instances", oFloatingText);
feedback.display_text = "+5 Doko";
feedback.text_color = c_lime;

instance_destroy(other);
