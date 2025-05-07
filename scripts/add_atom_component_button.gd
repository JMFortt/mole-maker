extends Button

@onready var root = get_parent().get_parent()

func _on_add_button_pressed() -> void:
	AudioManager.button_click()
	var line_edit = get_parent().get_node("LineEdit")
	if get_parent().name == "Protons":
		#print("adding protons")
		root.add_atom_components("proton", int(line_edit.text))
	elif get_parent().name == "Neutrons":
		root.add_atom_components("neutron", int(line_edit.text))
		#print("adding neutrons")
	elif get_parent().name == "Electrons":
		root.add_atom_components("electron", int(line_edit.text))
		#print("adding electrons")
	else:
		push_error("Invalid 'add button' parent!")
