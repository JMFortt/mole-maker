extends Node2D

# radii for your three regions (in pixels)
@export var nucleus_radius: float = 64.0
@export var inner_radius: float   = 128.0
@export var outer_radius: float   = 192.0

# electron-shell capacity
@export var inner_e_max: int = 2
@export var outer_e_max: int = 8

# preload the draggable-particle scene
var DraggableScene: PackedScene = preload("res://scenes/level1/DraggableParticle.tscn")

# counts
var proton_count: int   = 0
var neutron_count: int  = 0
var inner_e_count: int  = 0
var outer_e_count: int  = 0


func _ready() -> void:
	# setup sources
	_setup_source($ProtonSource,   "proton",   preload("res://assets/proton.png"))
	_setup_source($NeutronSource,  "neutron",  preload("res://assets/neutron.png"))
	_setup_source($ElectronSource, "electron", preload("res://assets/electron.png"))

	# connect drop zone signals
	$DropZones/NucleusZone.area_entered.connect(_on_NucleusZone_area_entered)
	$DropZones/InnerShellZone.area_entered.connect(_on_InnerShellZone_area_entered)
	$DropZones/OuterShellZone.area_entered.connect(_on_OuterShellZone_area_entered)

	_update_counters()

func _setup_source(button: TextureButton, ptype: String, tex: Texture2D) -> void:
	var cb: Callable = Callable(self, "_on_source_pressed").bind(ptype, tex)
	button.pressed.connect(cb)

func _on_source_pressed(ptype: String, tex: Texture2D) -> void:
	var p: DraggableParticle = DraggableScene.instantiate()
	p.type = ptype
	p.texture = tex
	add_child(p)
	p.global_position = get_global_mouse_position()
	p.dragging = true

# Nucleus (only proton or neutron, once)
func _on_NucleusZone_area_entered(area: Object) -> void:
	if not (area is DraggableParticle):
		return
	var p := area as DraggableParticle
	print("[NUCLEUS] entered by type=", p.type, " zone=", p.zone)

	# if it’s already been placed, leave it alone
	if p.zone != -1:
		print("[NUCLEUS] ignoring already placed particle")
		return

	# only protons/neutrons on first drop
	if p.type in ["proton", "neutron"]:
		# stop following the mouse
		p.dragging = false
		# snap to the center of the nucleus
		p.global_position = $DropZones/NucleusZone.global_position
		p.zone = 0
		# increment the correct counter
		if p.type == "proton":
			proton_count += 1
		else:
			neutron_count += 1
		print("[NUCLEUS] placed", p.type, "  counts:", proton_count, neutron_count)
		_update_counters()
		return

	# wrong type → remove
	print("[NUCLEUS] wrong type, queue_free()", p.type)
	p.queue_free()


# Inner shell (only electron, once)
func _on_InnerShellZone_area_entered(area: Object) -> void:
	if not (area is DraggableParticle):
		return
	var p := area as DraggableParticle 
	 
	print("[INNER] entered by type=", p.type, " zone=", p.zone, " inner_count=", inner_e_count)

	# once placed, do nothing
	if p.zone != -1:
		print("[INNER] ignoring already placed particle")
		return

	# only electrons here
	if p.type == "electron":
		p.dragging = false
		p.global_position = $DropZones/InnerShellZone.global_position
		p.zone = 1
		inner_e_count += 1
		_update_counters()
		print("[INNER] placed electron  inner_e_count=", inner_e_count)
		return

	print("[INNER] wrong type or other, queue_free()", p.type)
	p.queue_free()


# Outer shell (only electron, inner must be full, once)
func _on_OuterShellZone_area_entered(area: Object) -> void:
	if not (area is DraggableParticle):
		return
	var p := area as DraggableParticle
	
	print("[OUTER] entered by type=", p.type, " zone=", p.zone, " inner_count=", inner_e_count)

	# once placed, do nothing
	if p.zone != -1:
		print("[OUTER] ignoring already placed particle")
		return

	# only electrons, and only after inner shell has >= inner_e_max
	if p.type == "electron" and inner_e_count >= inner_e_max:
		p.dragging = false
		p.global_position = $DropZones/OuterShellZone.global_position
		p.zone = 2
		outer_e_count += 1
		_update_counters()
		print("[OUTER] placed electron  outer_e_count=", outer_e_count)
		return

	print("[OUTER] wrong type or inner not full, queue_free()", p.type)
	p.queue_free()


func _update_counters() -> void:
	$ProtonCountLabel.text   = str(proton_count)
	$NeutronCountLabel.text  = str(neutron_count)
	$InnerECountLabel.text   = str(inner_e_count)
	$OuterECountLabel.text   = str(outer_e_count)
	
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")
