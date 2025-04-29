extends Node

var current_level_data = null
signal stage_access_enabled(stage_name: String)

func start_level(level_name: String):
	print("level start: " + level_name)
	if level_name == "level_1":
		var level_data_script = preload("res://scenes/level1/level_1_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_2":
		pass
	elif level_name == "level_3":
		pass
	else:
		push_error("invalid level selected!")

func end_level():
	print("level over!")
	current_level_data = null

# to prevent "declared but not used" warnings for things called by other scripts
func _ignore():
	stage_access_enabled
