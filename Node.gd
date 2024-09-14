extends Node

var spawn_interval = 2
var spawn_timer = 0
var value = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	$Label.text = " Score : "+str(value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_timer -= delta
	if spawn_timer <= 0 :
		spawn_apple()
		spawn_timer = spawn_interval
		
func spawn_apple():
	var apple = $Apple
	var random_x = randf_range(0, get_viewport().size.x)
	apple.position = Vector2(random_x, 0)
