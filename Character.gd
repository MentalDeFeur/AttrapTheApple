extends CharacterBody2D


const JUMP_VELOCITY = 400
var DRAG_SPEED = 1000
@onready var animate = $Personnage
var start_drag_position = Vector2()
var is_dragging=false
var touch_pos=0

func _ready():
	start_drag_position = get_viewport().get_visible_rect().size
	$Personnage.play("idle")
	pass

func _input(event):
	if event is InputEventScreenDrag:
		is_dragging=true
		position.x += event.relative.x
		$Personnage.play("run")
		
func _physics_process(delta: float) -> void:
	
	if get_tree().paused:
		return
		
	velocity.y = JUMP_VELOCITY
	if velocity.length() > 0:
		velocity = velocity.move_toward(Vector2.ZERO,delta)
		
	if is_dragging:
		position.x = clamp(position.x,0,start_drag_position.x)
	
	move_and_slide()
	
	
