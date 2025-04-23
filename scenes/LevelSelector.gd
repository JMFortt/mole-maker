extends Node2D 

func _ready():
	# correct path: UI → Level1Button
	$UI/Level1Button.pressed.connect(_on_Level1Button_pressed)


func _on_Level1Button_pressed():
	get_tree().change_scene_to_file("res://scenes/level1/Level1.tscn")
