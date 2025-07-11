extends Node

# level select record variables
var level_name = "level_1"
var star_rating = null

# stage completed variables
var lab_line_completed = false # set true by dialogue button completion
var atom_assembler_completed = false
var molecule_maker_completed = false # set true by molecule_maker script
var synthesis_station_completed = false # set true by Q/A button success

# star system variables
var guess_answered_correctly = false
var level_start_time = Time.get_ticks_msec()
var timer_limit = 180

# lab line variables
var ticket_text = "[b]Want to make:\nNaOH[/b]
-------------------
2NaCl+2H2O \n->\n2NaOH+Cl2+?
-------------------
[b]Make atoms:[/b]\nNa, H, O, Cl
[b]Make molecules:[/b]\nH20, NaCl"
var customer_dialogues = [
		[
			"Hi there!",
			"I would like to order some NaOH, please.",
			"I want to make more soap with it!",
			"Thanks! I'll be waiting!"
		]
	]
var customer = preload("res://prefabs/level1/customer.tscn")

# atom assembler variables
const required_atoms = ["H", "O", "Na", "Cl"]
var current_atoms = []

# molecule maker variables
var drag_and_drop = preload("res://prefabs/level1/drag_and_drop.tscn")

# synthesis station variables
var synthesis_quiz = preload("res://prefabs/level1/synthesis_quiz.tscn")

# level completed variables
var character_sprite = preload("res://prefabs/level1/character_sprite.tscn")
var level_completed_message = "[b]Level 1 Completed![/b]"

# run every time an atom is made successfully
func check_atom_assembler_completed():
	for atom in required_atoms:
		if atom not in current_atoms:
			atom_assembler_completed = false
			return
	atom_assembler_completed = true
	return

func get_star_rating() -> Array:
	var num_stars = 1
	var messages = []
	# check timer
	var time_elapsed = (Time.get_ticks_msec() - level_start_time) / 1000.0
	print("time to complete level: ", time_elapsed)
	if time_elapsed  <= timer_limit:
		num_stars += 1
	else:
		messages.append("See if you can go even faster next time!")
	# check if final guess was correct
	if guess_answered_correctly:
		num_stars += 1
	else:
		messages.append("Was the extra product what you expected?")
	star_rating = num_stars
	return [num_stars, messages]
