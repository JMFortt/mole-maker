extends Area2D

signal released(p: DraggableParticle)

var zone: int = -1              # 0 nucleus, 1 inner, 2 outer, –1 none
@export var type: String
@export var texture: Texture2D

var dragging := false
var input_active := false       # became active by a click

func _ready():
	$Sprite2D.texture = texture
	# be sure the collision is ON
	$CollisionShape2D.disabled = false
	set_process(true)

func start_drag():
	dragging     = true
	input_active = true
	#  Disable source buttons so you can’t spawn more
	get_parent()._set_sources_enabled(false)

func _set_sources_enabled(enabled: bool) -> void:
	$ProtonSource.disabled   = not enabled
	$NeutronSource.disabled  = not enabled
	$ElectronSource.disabled = not enabled

func stop_drag():
	dragging     = false
	input_active = false
	emit_signal("released", self)
	#  Re-enable source buttons
	get_parent()._set_sources_enabled(true)





func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		var parent := get_parent()            # AtomAssembler

		if event.pressed:
			# only start if no one else is being dragged
			if parent.current_dragging == null:
				parent.current_dragging = self
				start_drag()
		else:
			if input_active:
				stop_drag()

func _process(_dt):
	if dragging:
		global_position = get_global_mouse_position()

		# Auto-snap if we hover a valid zone
		var parent := get_parent()            # AtomAssembler
		var target_zone: int = parent._get_zone(global_position, type)
		if target_zone >= 0:
			stop_drag()

	# Fallback: user released outside shape
	if input_active and not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		stop_drag()
