extends Node2D

var elapsed_time := 0

func _ready():
	$UpdateTimer.start()

func _on_update_timer_timeout():
	elapsed_time += 1
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	$TimerLabel.text = "%d:%02d" % [minutes, seconds]
