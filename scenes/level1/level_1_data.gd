extends Node

var lab_line_completed = false # set true by dialogue button completion
var atom_assembler_completed = false
var molecule_maker_completed = false
var synthesis_station_completed = false # set true by Q/A button success

# atom assembler variables
const required_atoms = ["H"]
var current_atoms = []

# molecule maker variables
var atoms_placed_correctly = [false]

# run every time an atom is made successfully
func check_atom_assembler_completed():
	for atom in required_atoms:
		if atom not in current_atoms:
			atom_assembler_completed = false
			return
	atom_assembler_completed = true
	return

# run every time an atom is placed successfully
func check_molecule_maker_completed():
	for placement in atoms_placed_correctly:
		if placement == false:
			molecule_maker_completed = false
			return
	molecule_maker_completed = true
	return
