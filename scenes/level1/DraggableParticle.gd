class_name DraggableParticle
extends Area2D

var zone: int = -1
@export var type: String
@export var texture: Texture2D
var dragging := false

func _ready():
	$Sprite2D.texture = texture
	set_process(true)

func start_drag():
	dragging = true

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if zone != -1:
				get_parent()._on_particle_removed(self, zone)
				zone = -1
			dragging = true
		else:
			# STOP dragging, but do NOT notify parent here
			dragging = false

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position()
