class_name DraggableParticle
extends Area2D

signal released(p: DraggableParticle)

var zone: int = -1			# 0 nucleus, 1 inner, 2 outer, –1 none
@export var type: String
@export var texture: Texture2D

var dragging: bool     = false
var input_active: bool = false
var assembler: Node    = null

func _ready():
	$Sprite2D.texture          = texture
	$CollisionShape2D.disabled = false
	input_pickable             = true		# ← set on the Area2D itself
	set_process(true)

	# find AtomAssembler above us
	assembler = find_parent("AtomAssembler")
	if assembler == null:
		assembler = get_parent()


func start_drag():
	dragging     = true
	input_active = true
	if assembler.has_method("_set_sources_enabled"):
		assembler._set_sources_enabled(false)

func stop_drag():
	dragging     = false
	input_active = false
	if assembler.has_method("_set_sources_enabled"):
		assembler._set_sources_enabled(true)
	assembler.current_dragging = null	# clear lock
	emit_signal("released", self)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if assembler.current_dragging == null:
				assembler.current_dragging = self
				start_drag()
		else:
			if input_active:
				stop_drag()

func _process(_dt):
	if dragging:
		global_position = get_global_mouse_position()

		# Auto-snap if we hover a valid zone
		if assembler.has_method("_get_zone"):
			var target_zone: int = assembler._get_zone(global_position, type)
			if target_zone >= 0:
				stop_drag()

	# Fallback: mouse released off-shape
	if input_active and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		stop_drag()
