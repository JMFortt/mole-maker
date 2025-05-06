extends Button

func _on_pressed_molecule_maker() -> void:
	# start of debug section:
	GameManager.current_level_data.current_atoms.append("H")
	GameManager.current_level_data.current_atoms.append("Na")
	GameManager.current_level_data.current_atoms.append("O")
	GameManager.current_level_data.current_atoms.append("Cl")
	# end of debug section:
	
	if GameManager.current_level_data:
		GameManager.current_level_data.check_atom_assembler_completed()
		if GameManager.current_level_data.atom_assembler_completed:
			#print("Atom assembler stage completed!")
			# enable next stage
			GameManager.current_level_data.atom_assembler_completed = true
			GameManager.emit_signal("stage_access_enabled", "molecule_maker")
			#print("next stage available!")
		else:
			#print("Atom assembler stage not completed.")
			pass
	else:
		push_error("No current level data!")

func _on_pressed_synthesis_station() -> void:
	# enable next stage
	GameManager.emit_signal("stage_access_enabled", "synthesis_station")
