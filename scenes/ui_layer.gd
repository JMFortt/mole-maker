extends CanvasLayer

var elapsed_time := 0

func _ready():
	$TimerLabel/UpdateTimer.start()

func _on_UpdateTimer_timeout():
	elapsed_time += 1
	var minutes = elapsed_time / 60
	var seconds = elapsed_time % 60
	$TimerLabel.text = "%d:%02d" % [minutes, seconds]
