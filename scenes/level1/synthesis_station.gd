extends Node2D

@onready var ingredient1 = $Ingredient1
@onready var ingredient2 = $Ingredient2
@onready var result1 = $Result1
@onready var result2 = $Result2
@onready var poof = $GPUParticles2D
@onready var success_message = $SuccessMessage
var starting_pos1 = null
var starting_pos2 = null
var ending_pos1 = null
var ending_pos2 = null
var center = null

func _ready() -> void:
	center = (result1.position + result2.position) / 2
	starting_pos1 = ingredient1.position
	starting_pos2 = ingredient2.position
	ending_pos1 = result1.position
	ending_pos2 = result2.position

func _on_mix_button_pressed() -> void:
	mix()
	$MixButton.disabled = true

func mix():
	var swirl_time = 2

	# animate swirl using a tween method
	var ingredient_tween = create_tween()
	ingredient_tween.tween_method(Callable(self, "_update_swirl"), 0.0, 3.0 * TAU, swirl_time)
	# fade out ingredients
	ingredient_tween.parallel().tween_property(ingredient1, "modulate", Color(1, 1, 1, 0), swirl_time)
	ingredient_tween.parallel().tween_property(ingredient2, "modulate", Color(1, 1, 1, 0), swirl_time)
	ingredient_tween.parallel().tween_property($MixButton, "modulate", Color(1, 1, 1, 0), swirl_time)
	await ingredient_tween.finished

	# poof
	print("poof!")
	poof.position = center
	poof.emitting = true
	
	# hide original ingredients
	ingredient1.visible = false
	ingredient2.visible = false
	ingredient2.visible = false
	$MixButton.visible = false
	
	# show result
	result1.position = center
	result2.position = center
	result1.visible = true
	result2.visible = true
	success_message.visible = true
	# animate fade-in with a tween
	var result_tween = create_tween()
	result_tween.parallel().tween_property(result1, "modulate", Color("#ffffff"), swirl_time)
	result_tween.parallel().tween_property(result2, "modulate", Color("#ffffff"), swirl_time)
	result_tween.parallel().tween_property(result1, "position", ending_pos1, swirl_time)
	result_tween.parallel().tween_property(result2, "position", ending_pos2, swirl_time)
	# face in success message
	result_tween.parallel().tween_property(success_message, "modulate", Color("#ffffff"), swirl_time)
	await result_tween.finished


func _update_swirl(angle: float):
	var total_angle = 3.0 * TAU
	var progress = clamp(angle / total_angle, 0.0, 1.0)

	var max_radius = 200.0
	var min_radius = 20.0
	var radius = lerp(max_radius, min_radius, progress)

	ingredient1.position = center + Vector2.LEFT.rotated(angle) * radius
	ingredient2.position = center + Vector2.RIGHT.rotated(angle) * radius

	var modifier = lerp(1.0, 0.5, progress)
	ingredient1.scale = Vector2.ONE * modifier
	ingredient2.scale = Vector2.ONE * modifier
