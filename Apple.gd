extends CharacterBody2D

@export var fall_speed: float = 300.0
@export var is_poison: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_self: CollisionShape2D = $CollisionShape2D
@onready var collision_area: CollisionShape2D = get_parent().get_node_or_null("CollisionShape2D")
@onready var root: Node2D = get_parent().get_parent()

var is_collected: bool = false

func _ready() -> void:
	if sprite:
		sprite.play("apple")
		if is_poison:
			sprite.modulate = Color(0.75, 0.2, 0.95, 1.0)
		else:
			sprite.modulate = Color(1.0, 1.0, 1.0, 1.0)

func set_as_poison() -> void:
	is_poison = true
	fall_speed = 340.0
	if sprite:
		sprite.modulate = Color(0.75, 0.2, 0.95, 1.0)

func _process(delta: float) -> void:
	if is_collected:
		return
		
	if root:
		root.position.y += fall_speed * delta
		
		# Toxic pulsation effect if poisoned
		if is_poison and sprite:
			var pulse = 0.85 + 0.15 * sin(Time.get_ticks_msec() * 0.008)
			sprite.modulate = Color(0.75 * pulse, 0.2 * pulse, 0.95, 1.0)
			
		# Clean despawn when falling past bottom
		if root.position.y > 800:
			root.queue_free()

func collect() -> void:
	if is_collected:
		return
	is_collected = true
	
	if collision_self:
		collision_self.set_deferred("disabled", true)
	if collision_area:
		collision_area.set_deferred("disabled", true)
		
	if sprite:
		sprite.speed_scale = 3.0
		sprite.play("collected")
		
		var tw = create_tween()
		tw.tween_property(sprite, "scale", sprite.scale * 1.35, 0.12)
		tw.parallel().tween_property(sprite, "modulate:a", 0.0, 0.22)
		tw.tween_callback(func():
			if root:
				root.queue_free()
		)
	else:
		if root:
			root.queue_free()
