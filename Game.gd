extends Node

var spawn_timer: float = 0

var AppleScene = preload("res://Apple.tscn")
var time_left = 0

func _ready():
	$MusicAttrap.play()
	time_left = Global.game_time
	
func _process(delta):
	$Score.text = "Score : " + str(Global.score)
	spawn_timer -= time_left
	if spawn_timer <= 0:
		_spawn_apple()
	

func _spawn_apple():
		var apple = AppleScene.instantiate()
		var random_x = randf_range(0,1080)
		apple.position = Vector2(random_x, 0)
		add_child(apple)
		

func _on_area_character_body_entered(body: Node2D) -> void:
	Global.score += 1
