extends CharacterBody2D


const SPEED = 600.0
const JUMP_VELOCITY = 400
@onready var animate = $AnimatedSprite2D
var value = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass
	
func _physics_process(delta):
	# Handle jump
	velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right") 
	
	if direction:
		velocity.x = direction * SPEED
		animate.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animate.play("idle")

	move_and_slide()
	



