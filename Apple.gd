extends CharacterBody2D

var fall_speed: float = 300

func _process(delta):
	get_parent().get_parent().position.y += fall_speed * delta
