extends Node2D 

var levels = ["level_1", "level_2", "level_3"]
var star_color = Color("#fed430")

func _ready():
	# correct path: UI → Level1Button
	$UI/Level1Button.pressed.connect(_on_Level1Button_pressed)
	display_stars_and_unlocks()

func display_stars_and_unlocks():
	# go through all known levels
	for level_name in levels:
		var level_num = level_name.split("_")[1]
		var level_button = get_node("UI/Level" + level_num + "Button")
		# if the level right before has been unlocked, unlock it
		if level_button.disabled:
			var prev_index = levels.find(level_name) - 1
			if GameManager.level_records.has(levels[prev_index]):
				level_button.disabled = false
		# if it has a rating recorded, display it
		if GameManager.level_records.has(level_name):
			var star_rating = GameManager.level_records[level_name]
			if star_rating >= 1:
				level_button.get_node("Star1/StarMain").color = star_color
			if star_rating >= 2:
				level_button.get_node("Star2/StarMain").color = star_color
			if star_rating >= 3:
				level_button.get_node("Star3/StarMain").color = star_color

func _on_Level1Button_pressed():
	get_tree().change_scene_to_file("res://scenes/level1/Level1.tscn")


func _on_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
