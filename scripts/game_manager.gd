extends Node

var current_level_data = null
var level_records = {}
signal stage_access_enabled(stage_name: String)

func start_level(level_name: String):
	#print("level start: " + level_name)
	if level_name == "level_1":
		var level_data_script = preload("res://scripts/level_1_data.gd")
		current_level_data = level_data_script.new()
	elif level_name == "level_2":
		pass
	elif level_name == "level_3":
		pass
	else:
		push_error("invalid level selected!")

func end_level():
	#print("level over!")
	# record star rating if level is completed
	if current_level_data.star_rating:
		#print("star rating recorded: ", current_level_data.star_rating)
		# if rating already achieved, keep best
		if level_records.has(current_level_data.level_name):
			level_records[current_level_data.level_name] = max(current_level_data.star_rating, level_records[current_level_data.level_name])
		# otherwise record new rating
		else:
			level_records[current_level_data.level_name] = current_level_data.star_rating
	#else:
		#print("no star rating found")
	current_level_data = null
	#print("level records: ", level_records)
