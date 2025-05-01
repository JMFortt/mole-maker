class_name NewDraggableParticle

extends TextureButton
@export var particle_type : String
@export var icon          : Texture2D

func _ready() -> void:
	texture_normal = icon

func _get_drag_data(_pos):
	# preview sprite
	var preview := TextureRect.new()
	preview.texture  = icon
	preview.scale    = Vector2(0.8, 0.8)
	preview.position = -preview.size / 2
	set_drag_preview(preview)

	# payload: just a dictionary
	return { "type": particle_type }
