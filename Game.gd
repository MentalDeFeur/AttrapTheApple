extends Node

var spawn_interval : float = 1.3
var spawn_timer = 0
var value = Global.value
# Called when the node enters the scene tree for the first time.
func _ready():
	$MusicAttrap.play()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	set_process(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_apple()
		spawn_timer = spawn_interval
		
func spawn_apple():
	var apple = $NodeApple/Area2D/Apple
	$NodeApple/Area2D/Apple/AnimatedSprite2D.play("apple")
	var random_x = randf_range(0,648)
	apple.position = Vector2(random_x, 0)
	add_child(apple)
	
func _on_area_character_body_entered(body: Node2D) -> void:
		$AppleCollected.play()
		$NodeApple/Area2D/Apple/AnimatedSprite2D.play("collected")
		value += 1
		$Score.text = "Score : {value}".format({"value": value})
		
func _on_character_child_exiting_tree(node: Node) -> void:
	queue_free()
