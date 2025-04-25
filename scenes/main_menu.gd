extends Node2D


func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_select.tscn")


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")


func _on_how_to_play_button_pressed() -> void:
	$UI/HowToPlayOverlay.visible = true


func _on_close_overlay_button_pressed() -> void:
	$UI/HowToPlayOverlay.visible = false
