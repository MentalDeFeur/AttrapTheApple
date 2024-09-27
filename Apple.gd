extends CharacterBody2D

var gravity = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play('apple')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	move_and_slide()

