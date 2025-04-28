extends Node2D

@export var nucleus_radius: float = 64.0
@export var inner_radius: float = 128.0
@export var outer_radius: float = 192.0

@export var inner_e_max: int = 2
@export var outer_e_max: int = 8

var DraggableScene: PackedScene = preload("res://scenes/level1/DraggableParticle.tscn")

var proton_count: int = 0
var neutron_count: int = 0
var inner_e_count: int = 0
var outer_e_count: int = 0

func _ready():
	_setup_source($ProtonSource, "proton", preload("res://assets/proton.png"))
	_setup_source($NeutronSource, "neutron", preload("res://assets/neutron.png"))
	_setup_source($ElectronSource, "electron", preload("res://assets/electron.png"))
	_update_counters()

func _setup_source(button: TextureButton, ptype: String, tex: Texture2D) -> void:
	var cb = Callable(self, "_on_source_pressed").bind(ptype, tex)
	button.pressed.connect(cb)

func _on_source_pressed(ptype: String, tex: Texture2D) -> void:
	var p: DraggableParticle = DraggableScene.instantiate()
	p.type = ptype
	p.texture = tex
	p.released.connect(_on_particle_released)  # <--- listen for drop
	add_child(p)
	p.global_position = get_global_mouse_position()
	p.dragging = true

func _on_particle_released(p: DraggableParticle) -> void:
	if p.zone != -1:
		return  # already placed, ignore

	var zone = _get_zone(p.global_position, p.type)

	if zone == -1:
		p.queue_free()
		return

	# snap to correct location
	match zone:
		0: p.global_position = $DropZones/NucleusZone.global_position
		1: p.global_position = $DropZones/InnerShellZone.global_position
		2: p.global_position = $DropZones/OuterShellZone.global_position

	p.zone = zone
	p.dragging = false

	# update counts
	match p.type:
		"proton":
			if zone == 0: proton_count += 1
		"neutron":
			if zone == 0: neutron_count += 1
		"electron":
			if zone == 1: inner_e_count += 1
			elif zone == 2: outer_e_count += 1

	_update_counters()

func _get_zone(pos: Vector2, ptype: String) -> int:
	var d = pos.length()
	if ptype in ["proton", "neutron"]:
		return 0 if d <= nucleus_radius else -1
	if ptype == "electron":
		if d <= nucleus_radius:
			return -1
		if d <= inner_radius:
			return 1
		if inner_e_count >= inner_e_max and d <= outer_radius:
			return 2
	return -1

func _update_counters():
	$ProtonCountLabel.text = str(proton_count)
	$NeutronCountLabel.text = str(neutron_count)
	$InnerECountLabel.text = str(inner_e_count)
	$OuterECountLabel.text = str(outer_e_count)
