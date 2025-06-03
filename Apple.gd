extends CharacterBody2D

var gravity = 500

func _ready():
	pass
	
func _process(delta):
	velocity.y += gravity * delta
	move_and_slide()
