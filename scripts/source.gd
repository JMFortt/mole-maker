extends Control

var clone_count = 0
@onready var molecule_maker = get_parent()

func _gui_input(event):
	# make clone on click
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		# make a clone
		var clone = duplicate()
		# different name for each clone
		if GameManager.current_level_data.level_name == "level_3":
			clone.scale = Vector2(0.5, 0.5)
		clone.name = name + "_" + str(clone_count)
		clone_count += 1
		clone.set_script(load("res://scripts/placed_object.gd"))
		# add to correct scene
		molecule_maker.add_child(clone)
		clone.global_position = get_viewport().get_mouse_position()
		clone.start_drag()
