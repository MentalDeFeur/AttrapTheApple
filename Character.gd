extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = 400
@onready var animate = $Personnage
var friction = 800


func _ready():
	pass
	
func _input(event: InputEvent):
	if event is InputEventScreenDrag:
		velocity = (event.relative).normalized() * SPEED
		animate.play("run")
	elif event is InputEventScreenTouch and not event.pressed:
		velocity = velocity
		animate.play("idle")
	else: 
		animate.play("idle")
	
func _physics_process(delta: float) -> void:
	velocity.y = JUMP_VELOCITY
	
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO,friction * delta)
		
	move_and_slide()
