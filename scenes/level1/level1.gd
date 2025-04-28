extends Node2D

# 1️⃣ Preload your two stage scenes
var LabLineScene = preload("res://scenes/level1/LabLine.tscn")
var AtomAssemblerScene = preload("res://scenes/level1/AtomAssembler.tscn")
var MoleculeMakerScene = preload("res://scenes/level1/MoleculeMaker.tscn")
var SythesisStationScene = preload("res://scenes/level1/SynthesisStation.tscn")

# 2️⃣ Hold references to the instances
var lab_line: Node2D
var atom_assembler: Node2D
var molecule_maker: Node2D
var synthesis_station: Node2D

func _ready():
	# 3️⃣ Instance both, add under StageContainer
	lab_line = LabLineScene.instantiate()
	atom_assembler = AtomAssemblerScene.instantiate()
	molecule_maker = MoleculeMakerScene.instantiate()
	synthesis_station = SythesisStationScene.instantiate()
	
	$StageContainer.add_child(lab_line)
	$StageContainer.add_child(atom_assembler)
	$StageContainer.add_child(molecule_maker)
	$StageContainer.add_child(synthesis_station)

	# 4️⃣ Show only Lab Line by default
	lab_line.visible = true
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = false

	# 5️⃣ Hook up your two buttons
	$UILayer/StageNavBar/LabLineButton.connect("pressed", Callable(self, "_on_LabLineButton_pressed"))
	$UILayer/StageNavBar/AtomAssemblerButton.connect("pressed", Callable(self, "_on_AtomAssemblerButton_pressed"))
	$UILayer/StageNavBar/MoleculeMakerButton.connect("pressed", Callable(self, "_on_MoleculeMakerButton_pressed"))
	$UILayer/StageNavBar/SynthesisStationButton.connect("pressed", Callable(self, "_on_SynthesisStationButton_pressed"))

func _on_LabLineButton_pressed():
	lab_line.visible = true
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = false

func _on_AtomAssemblerButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = true
	molecule_maker.visible = false
	synthesis_station.visible = false

func _on_MoleculeMakerButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = false
	molecule_maker.visible = true
	synthesis_station.visible = false

func _on_SynthesisStationButton_pressed():
	lab_line.visible = false
	atom_assembler.visible = false
	molecule_maker.visible = false
	synthesis_station.visible = true

func _on_hint_button_pressed():
	# get hint overlay for that scene
	# show hint overlay
	pass

func _on_periodic_table_button_pressed():
	# show periodic table overlay
	$UILayer/PeriodicTableOverlay.visible = true

func _on_options_button_pressed():
	# show options overlay
	pass

func _on_back_button_pressed() -> void:
	# back to level select
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")

func _on_close_periodic_table_button_pressed() -> void:
	# hide periodic table overlay
	$UILayer/PeriodicTableOverlay.visible = false

func _switch_to_atom_assembler() -> void:
	lab_line.visible = false
	atom_assembler.visible = true
	molecule_maker.visible = false
	synthesis_station.visible = false
