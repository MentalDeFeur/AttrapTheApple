extends Node

var spawn_timer: float = 0.0
var spawn_interval: float = 0.3
var time_left: int = 60
var time_accumulator: float = 0.0

var _local_score: int = 0
var score: int:
	get:
		var g = get_node_or_null("/root/Global")
		return g.score if g else _local_score
	set(value):
		_local_score = value
		var g = get_node_or_null("/root/Global")
		if g:
			g.score = value

var AppleScene = preload("res://Apple.tscn")

@onready var pause_menu = $PauseMenu
@onready var sfx_player = $CatchSfx
@onready var score_label = $Score
@onready var temps_label = $Temps

func _ready() -> void:
	if has_node("MusicAttrap") and $MusicAttrap.stream:
		$MusicAttrap.play()
		
	var g = get_node_or_null("/root/Global")
	if g:
		spawn_interval = g.spawn_interval
		time_left = g.game_time
		
	spawn_timer = spawn_interval
	_update_score_display()

func _process(delta: float) -> void:
	if time_left <= 0:
		get_tree().change_scene_to_file("res://Main.tscn")
		return
		
	if temps_label:
		temps_label.text = "Temps : " + str(time_left)
		# Alerte visuelle pour les 10 dernières secondes
		if time_left <= 10:
			temps_label.modulate = Color(1.0, 0.25, 0.25)
		else:
			temps_label.modulate = Color(1.0, 1.0, 1.0)
		
	# Gestion de l'intervalle d'apparition des pommes
	spawn_timer -= delta
	if spawn_timer <= 0:
		_spawn_apple()
		spawn_timer = spawn_interval
		
	# Gestion du temps restant
	time_accumulator += delta
	if time_accumulator >= 1.0:
		time_left -= 1
		time_accumulator = 0.0
		if time_left <= 10 and time_left > 0:
			_pulse_timer()

func _spawn_apple() -> void:
	var apple = AppleScene.instantiate()
	var random_x = randf_range(60, 1020)
	apple.position = Vector2(random_x, -100)
	add_child(apple)
	
	var apple_body = apple.get_node_or_null("Area2D/Apple")
	# 25% de chances que la pomme soit empoisonnée
	if apple_body and randf() < 0.25:
		apple_body.set_as_poison()
		
	var area = apple.get_node_or_null("Area2D")
	if area:
		area.connect("body_entered", _on_apple_body_entered.bind(apple))

func _on_apple_body_entered(body: Node2D, apple: Node2D) -> void:
	if body.name == "Character":
		var apple_body = apple.get_node_or_null("Area2D/Apple")
		var spawn_pos = apple.position + Vector2(128, 110)
		
		if apple_body and apple_body.is_poison:
			# Malus pour la pomme empoisonnée
			score = max(0, score - 2)
			_update_score_display()
			_show_floating_text(spawn_pos, "-2 Poison !", Color(0.85, 0.2, 0.95))
			_play_sfx(0.55)
			
			if body.has_method("play_hurt_effect"):
				body.play_hurt_effect()
			_shake_screen(6.0, 0.2)
		else:
			# Bonus pour la pomme normale
			score += 1
			_update_score_display()
			_show_floating_text(spawn_pos, "+1", Color(0.2, 1.0, 0.4))
			_play_sfx(randf_range(1.0, 1.25))
			
			if body.has_method("play_catch_bounce"):
				body.play_catch_bounce()
				
		if apple_body and apple_body.has_method("collect"):
			apple_body.collect()
		else:
			apple.queue_free()

func _update_score_display() -> void:
	if score_label:
		score_label.text = "Score : " + str(score)
		score_label.pivot_offset = score_label.size / 2.0
		var tw = create_tween()
		tw.tween_property(score_label, "scale", Vector2(1.3, 1.3), 0.08)
		tw.tween_property(score_label, "scale", Vector2(1.0, 1.0), 0.12)

func _pulse_timer() -> void:
	if temps_label:
		temps_label.pivot_offset = temps_label.size / 2.0
		var tw = create_tween()
		tw.tween_property(temps_label, "scale", Vector2(1.25, 1.25), 0.1)
		tw.tween_property(temps_label, "scale", Vector2(1.0, 1.0), 0.15)

func _play_sfx(pitch: float) -> void:
	if sfx_player:
		sfx_player.pitch_scale = pitch
		sfx_player.play()

func _show_floating_text(pos: Vector2, text: String, color: Color) -> void:
	var label = Label.new()
	label.text = text
	label.add_theme_font_size_override("font_size", 28)
	label.add_theme_color_override("font_color", color)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	label.add_theme_constant_override("outline_size", 4)
	label.position = pos - Vector2(40, 20)
	label.z_index = 100
	add_child(label)
	
	var tw = create_tween()
	tw.tween_property(label, "position:y", pos.y - 65, 0.55).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tw.parallel().tween_property(label, "scale", Vector2(1.2, 1.2), 0.12)
	tw.chain().tween_property(label, "modulate:a", 0.0, 0.22)
	tw.tween_callback(label.queue_free)

func _shake_screen(intensity: float, duration: float) -> void:
	var tw = create_tween()
	var steps = int(duration / 0.04)
	for i in range(steps):
		var offset = Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		tw.tween_property(self, "position", offset, 0.04)
	tw.tween_property(self, "position", Vector2.ZERO, 0.04)

func _on_pause_button_pressed() -> void:
	if pause_menu:
		pause_menu.open()

func _on_area_character_body_entered(_body: Node2D) -> void:
	pass

func _on_character_child_exiting_tree(_node: Node) -> void:
	pass
