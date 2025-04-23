extends Node2D

# 1️⃣ Preload your two stage scenes
var LabLineScene = preload("res://scenes/level1/LabLine.tscn")
var AtomAssemblerScene = preload("res://scenes/level1/AtomAssembler.tscn")

# 2️⃣ Hold references to the instances
var lab_line: Node2D
var atom_assembler: Node2D

func _ready():
	# 3️⃣ Instance both, add under StageContainer
	lab_line = LabLineScene.instantiate()
	atom_assembler = AtomAssemblerScene.instantiate()
	$StageContainer.add_child(lab_line)
	$StageContainer.add_child(atom_assembler)

	# 4️⃣ Show only Lab Line by default
	lab_line.visible = true
	atom_assembler.visible = false

	# 5️⃣ Hook up your two buttons
	$UILayer/LabLineButton.connect("pressed", Callable(self, "_on_LabLineButton_pressed"))
	$UILayer/AtomAssemblerButton.connect("pressed", Callable(self, "_on_AtomAssemblerButton_pressed"))

	
	
func _on_LabLineButton_pressed():
	# show Lab Line, hide Atom Assembler
	lab_line.visible = true
	atom_assembler.visible = false

func _on_AtomAssemblerButton_pressed():
	# show Atom Assembler, hide Lab Line
	lab_line.visible = false
	atom_assembler.visible = true
