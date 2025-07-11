extends Node

var countdown = 60
@onready var timer = $GameTimer
@onready var label = $TimerLabel

func _ready() -> void:
	label.text = "Temps : " + str(countdown)
	timer.wait_time = 1.0
	timer.start()

func _on_game_timer_timeout() -> void:
	countdown -= 1
	if countdown <= 0:
		timer.stop()
		label.text = "Fin du temps"
		get_tree().change_scene_to_file("res://Main.tscn")
	else:
		label.text = str(countdown)
	
