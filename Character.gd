extends CharacterBody2D

const JUMP_VELOCITY = 400
var DRAG_SPEED = 1000
@onready var animate = $Personnage
var start_drag_position = Vector2()
var is_dragging = false
var touch_pos = 0
var last_drag_delta_x: float = 0.0

@onready var base_scale: Vector2 = scale
var bounce_tween: Tween
var hurt_tween: Tween

func _ready() -> void:
	start_drag_position = get_viewport().get_visible_rect().size
	$Personnage.play("idle")

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		is_dragging = true
		position.x += event.relative.x
		last_drag_delta_x = event.relative.x
	elif event is InputEventScreenTouch and not event.pressed:
		is_dragging = false
		last_drag_delta_x = 0.0
	elif event is InputEventMouseButton and not event.pressed:
		is_dragging = false
		last_drag_delta_x = 0.0

func _physics_process(delta: float) -> void:
	if get_tree().paused:
		return
		
	velocity.y = JUMP_VELOCITY
	
	# Contrôles clavier (Flèches, A/D, Q/D)
	var keyboard_dir = Input.get_axis("ui_left", "ui_right")
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_Q):
		keyboard_dir = -1.0
	elif Input.is_key_pressed(KEY_D):
		keyboard_dir = 1.0
		
	if keyboard_dir != 0:
		velocity.x = keyboard_dir * 550.0
	else:
		velocity.x = move_toward(velocity.x, 0.0, 3000.0 * delta)
		
	# Gestion de l'orientation et de l'animation de course / attente
	var is_moving = abs(velocity.x) > 10.0 or (is_dragging and abs(last_drag_delta_x) > 0.1)
	if is_moving:
		$Personnage.play("run")
		if velocity.x < -10.0 or (is_dragging and last_drag_delta_x < -0.1):
			$Personnage.flip_h = true
		elif velocity.x > 10.0 or (is_dragging and last_drag_delta_x > 0.1):
			$Personnage.flip_h = false
	else:
		$Personnage.play("idle")
		
	move_and_slide()
	
	# Clamp position on screen edges
	position.x = clamp(position.x, 30.0, start_drag_position.x - 30.0)
	
	last_drag_delta_x = 0.0

# Animation de capture réussie (rebond squash & stretch)
func play_catch_bounce() -> void:
	if bounce_tween and bounce_tween.is_valid():
		bounce_tween.kill()
	bounce_tween = create_tween()
	bounce_tween.tween_property(self, "scale", Vector2(base_scale.x * 1.2, base_scale.y * 0.82), 0.07)
	bounce_tween.tween_property(self, "scale", Vector2(base_scale.x * 0.9, base_scale.y * 1.12), 0.08)
	bounce_tween.tween_property(self, "scale", base_scale, 0.09)

# Animation de dégât lors du contact avec une pomme empoisonnée
func play_hurt_effect() -> void:
	if hurt_tween and hurt_tween.is_valid():
		hurt_tween.kill()
	hurt_tween = create_tween()
	$Personnage.modulate = Color(2.0, 0.3, 0.4, 1.0)
	hurt_tween.tween_property($Personnage, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
	
	var orig_pos = $Personnage.position
	var shake_tw = create_tween()
	shake_tw.tween_property($Personnage, "position:x", orig_pos.x - 4.0, 0.04)
	shake_tw.tween_property($Personnage, "position:x", orig_pos.x + 4.0, 0.04)
	shake_tw.tween_property($Personnage, "position:x", orig_pos.x - 2.0, 0.04)
	shake_tw.tween_property($Personnage, "position:x", orig_pos.x, 0.04)
