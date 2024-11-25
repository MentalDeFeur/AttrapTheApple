extends CharacterBody2D


const JUMP_VELOCITY = 400
var DRAG_SPEED = 1000
@onready var animate = $Personnage
var start_drag_position = Vector2()
var is_dragging=false
var touch_pos=0

func _ready():
	pass

func _input(event):
	if event is InputEventScreenDrag:
		is_dragging=true
		touch_pos = event.position
		
func _physics_process(delta: float) -> void:
	velocity.y = JUMP_VELOCITY
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO,delta)
		
	if is_dragging:
		var direction = (touch_pos - global_position).normalized()
		velocity.x = direction.x * DRAG_SPEED
	
	move_and_slide()
		
