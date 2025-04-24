extends TextureButton
var dragging = false
func _gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		dragging = true
func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position()
