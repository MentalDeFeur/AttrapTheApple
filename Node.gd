extends Node

var spawn_interval : float = 1.3
var spawn_timer = 0
var value = Global.value

<<<<<<< HEAD:Game.gd
@onready var apple_template = $NodeApple/Area2D/Apple
var difficulty := 1.0
var base_interval := 1.2
var time_since_diff := 0.0

var AppleScene: PackedScene

=======
>>>>>>> parent of 090d0c6 (correctionbugaffichagejeu):Node.gd
# Called when the node enters the scene tree for the first time.
func _ready():
	$MusicAttrap.play()
	process_mode = Node.PROCESS_MODE_PAUSABLE
	AppleScene = PackedScene.new()
	AppleScene.pack(apple_template)
	# Garde le modèle hors jeu (évite de le free par erreur)
	apple_template.visible = false
	apple_template.set_process(false)
	apple_template.set_physics_process(false)
	set_process(true)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var ground_margin := 0.0  # ajuste si tu as un sol visuel, ex: 32.0
	spawn_timer -= delta
	if spawn_timer <= 0:
		spawn_apple()
		spawn_timer = spawn_interval
		
		time_since_diff += delta
		if time_since_diff >= 10.0:
			time_since_diff = 0.0
			difficulty += 2
			spawn_interval = max(0.35, spawn_interval * 0.9) # spawn plus fréquent

		# UPDATE des pommes (chute + drift + accélération)
		var view_h = get_viewport().get_visible_rect().size.y
		for apple in get_tree().get_nodes_in_group("apples"):
			# récup métadonnées
			var age = apple.get_meta("age", 0.0) + delta
			var speed = apple.get_meta("speed", 140.0) * difficulty
			var accel = apple.get_meta("accel", 220.0) * difficulty
			var drift_amp = apple.get_meta("drift_amp", 40.0) * difficulty
			var drift_freq = apple.get_meta("drift_freq", 2.0)
			var phase = apple.get_meta("phase", 0.0)

			# chute accélérée
			var vy = speed + accel * age
			apple.position.y += vy * delta

			# mouvement latéral (drift)
			apple.position.x += drift_amp * sin(drift_freq * age + phase) * delta

			# sauvegarde de l'âge
			apple.set_meta("age", age)
		
			if apple.position.y > view_h + 64:
				apple.queue_free()

func spawn_apple():
<<<<<<< HEAD:Game.gd
	# duplique le modèle (IMPORTANT: ne pas réutiliser le même nœud)
	var apple = apple_template.duplicate()
	apple.visible = true
	# animation
	if apple.has_node("AnimatedSprite2D"):
		apple.get_node("AnimatedSprite2D").play("apple")


=======
	var apple = $NodeApple/Area2D/Apple
<<<<<<< HEAD
>>>>>>> parent of 090d0c6 (correctionbugaffichagejeu):Node.gd
	var random_x = randf_range(0,648)
=======
	var random_x = randf_range(0,618)
>>>>>>> parent of adaca64 (ajoutcollisionjeu)
	apple.position = Vector2(random_x, 0)
	if apple.has_node("CollisionShape2D"):
		apple.get_node("CollisionShape2D").scale = Vector2(0.7, 0.7)

	# paramètres de difficulté/mouvements (métadonnées par instance)
	apple.set_meta("age", 0.0)
	apple.set_meta("speed", 140.0)         # vitesse de base
	apple.set_meta("accel", 220.0)         # accélération verticale
	apple.set_meta("drift_amp", 40.0)      # amplitude latérale
	apple.set_meta("drift_freq", 2.0)      # fréquence de drift
	apple.set_meta("phase", randf() * TAU) # phase aléatoire

	# groupage pour l'update global
	apple.add_to_group("apples")
	
	add_child(apple)
	
<<<<<<< HEAD:Game.gd
func _on_area_character_body_entered(body: Node2D) -> void: 
	if body.is_in_group("apples"):
		$NodeApple/Area2D/Apple/AnimatedSprite2D.play("collected")
=======
func _on_area_character_body_entered(body: Node2D) -> void:
>>>>>>> parent of 090d0c6 (correctionbugaffichagejeu):Node.gd
		value += 1
		$Score.text = "Score : {value}".format({"value": value})
		body.queue_free()
		$AppleCollected.play()
		

func _on_character_child_exiting_tree(node: Node) -> void:
		get_parent().queue_free()
	
	
