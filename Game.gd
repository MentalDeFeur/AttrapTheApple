extends Node

var spawn_timer: float = 0
var spawn_interval: float = Global.spawn_interval

var AppleScene = preload("res://Apple.tscn")
var time_left = 60
var time_accumulator: float = 0.0 # Ajouté pour gérer l'intervalle

func _ready():
	$MusicAttrap.play()
	time_left = Global.game_time
	spawn_timer = spawn_interval
	
func _process(delta):
	if time_left == 0:
		get_tree().change_scene_to_file("res://Main.tscn")
	else: 
		$Temps.text = "Temps : " + str(time_left)
		$Score.text = "Score : " + str(Global.score)
		spawn_timer -= delta
		if spawn_timer <= 0:
			_spawn_apple()
			spawn_timer = spawn_interval
		# Gestion du temps restant
		time_accumulator += delta
		if time_accumulator >= 1.0:
			time_left -= 1
			time_accumulator = 0.0
		
func _spawn_apple():
	var apple = AppleScene.instantiate()
	var random_x = randf_range(0,1080)
	apple.position = Vector2(random_x, -100)
	add_child(apple)
	apple.get_node("Area2D").connect("body_entered", _on_apple_body_entered.bind(apple))


func _on_apple_body_entered(body: Node2D, apple: Node2D) -> void:
	if body.name == "Character":
		Global.score += 1
		apple.queue_free()

func _on_area_character_body_entered(body: Node2D) -> void:
	pass
