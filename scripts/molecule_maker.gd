extends Node

@onready var drop_spots = $DropSpots.get_children() 

func check_solution():
	var correct = true
	# check all the spots to make sure they're all filled correctly
	for drop_spot in drop_spots:
		if drop_spot.current_object == null:
			correct = false
			break
	if correct:
		# enable next stage
		if GameManager.current_level_data:
			GameManager.current_level_data.molecule_maker_completed = true
			if GameManager.current_level_data.molecule_maker_completed:
				print("Molecule maker stage completed!")
				# enable next stage
				GameManager.current_level_data.molecule_maker_completed = true
				GameManager.emit_signal("stage_access_enabled", "synthesis_station")
				print("next stage available!")
			else:
				print("Molecule maker stage not completed.")
		else:
			push_error("No current level data!")
