extends Node2D

var customer_dialogues: Array = []
var current_customer: int = 0
var current_line: int = 0
var dialogue_finished: bool = false

func _ready() -> void:
	customer_dialogues = [
		[
			"Hi there!",
			"I would like to order some NaOH, please.",
			"I want to make soap with it!",
			"Thanks! I'll be waiting!"
		]
	]
	$DialogueUI.visible = true
	$DialogueUI/SkipButton.pressed.connect(_on_skip_pressed)
	current_line = 0
	$DialogueUI/DialogueLabel.text = customer_dialogues[current_customer][current_line]
	$DialogueUI/SkipButton.text = "Take Order"

func _on_skip_pressed() -> void:
	# if dialogue is finished, switch to atom assembler
	if dialogue_finished:
		get_parent().get_parent()._switch_to_atom_assembler()
		return
	# otherwise updte current text line
	current_line += 1
	var lines = customer_dialogues[current_customer]
	# if not at the final line
	if current_line < lines.size():
		$DialogueUI/DialogueLabel.text = lines[current_line]
		# first line case
		if current_line == 1:
			$DialogueUI/SkipButton.text = "Continue"
	# final line case
	elif current_line == lines.size():
		# stage completed
		dialogue_finished = true
		# reveal ticket text
		var ticket_text = get_parent().get_parent().get_node("UILayer/TicketSpawn/TicketText")
		if ticket_text:
			ticket_text.visible = true
		else:
			push_error("Cannot find TicketText node!")
		# enable next stage
		if GameManager.current_level_data:
			GameManager.current_level_data.lab_line_completed = true
			GameManager.emit_signal("stage_access_enabled", "atom_assembler")
			#print("next stage available!")
		$DialogueUI/SkipButton.text = "Next Stage"
