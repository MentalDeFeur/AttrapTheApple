extends CharacterBody2D

var gravity = 500
var value = 0
var label_ref : Label
var main_node : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	$Area2D/AnimatedSprite2D.play('apple')
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	move_and_slide()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		main_node.value += 1
		label_ref.text = " Score : " + str(main_node.value)
		call_deferred("queue_free")  # On supprime cette pomme uniquement
