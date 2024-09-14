extends CharacterBody2D

var gravity = 500
var value = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play('apple')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	move_and_slide()
	
func _on_area_character_body_entered(body: Node2D) -> void:
	if body.is_in_group("Character"):
		$Label.text = " Score : "+str(value+1)
	pass # Replace with function body.
