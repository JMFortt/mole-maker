extends Button


func _on_pressed_molecule_maker() -> void:
	# start of debug section:
	GameManager.current_level_data.current_atoms.append("H")
	GameManager.current_level_data.current_atoms.append("Na")
	GameManager.current_level_data.current_atoms.append("O")
	# end of debug section:
	
	if GameManager.current_level_data:
		GameManager.current_level_data.check_atom_assembler_completed()
		if GameManager.current_level_data.atom_assembler_completed:
			print("Atom assembler stage completed!")
			# enable next stage
			GameManager.current_level_data.atom_assembler_completed = true
			GameManager.emit_signal("stage_access_enabled", "molecule_maker")
			print("next stage available!")
		else:
			print("Atom assembler stage not completed.")
	else:
		push_error("No current level data!")

func _on_pressed_synthesis_station() -> void:
	# start of debug section:
	GameManager.current_level_data.current_molecules.append("H20")
	# end of debug section:
	
	# enable next stage
	if GameManager.current_level_data:
		GameManager.current_level_data.check_molecule_maker_completed()
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
