extends CharacterBody2D

var fall_speed: float = 300

func _process(delta):
	position.y += fall_speed * delta
	pass 
