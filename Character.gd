extends CharacterBody2D


const JUMP_VELOCITY = 400
@onready var animate = $Personnage
var start_drag_position = Vector2(0,0)
var is_dragging=false
var touch_pos=0

func _ready():
	pass
	
func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.is_pressed():
			is_dragging=true
		else:
			is_dragging=false
	if is_dragging:
		touch_pos = event.position
		
func _physics_process(delta: float) -> void:
	velocity.y = JUMP_VELOCITY
	
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO,delta)
	
	if is_dragging:
		$Personnage.global_position = touch_pos
		move_and_slide()
		
