extends CanvasLayer

signal resumed

@onready var overlay: ColorRect = $Overlay
@onready var panel: PanelContainer = $Overlay/CenterContainer/PanelContainer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func open() -> void:
	get_tree().paused = true
	visible = true
	overlay.modulate.a = 0.0
	panel.scale = Vector2(0.8, 0.8)
	panel.pivot_offset = panel.size / 2.0
	
	var tw = create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(overlay, "modulate:a", 1.0, 0.15)
	tw.parallel().tween_property(panel, "scale", Vector2(1.0, 1.0), 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

func close() -> void:
	var tw = create_tween()
	tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tw.tween_property(overlay, "modulate:a", 0.0, 0.12)
	tw.parallel().tween_property(panel, "scale", Vector2(0.8, 0.8), 0.12)
	tw.tween_callback(func():
		visible = false
		get_tree().paused = false
		emit_signal("resumed")
	)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or (event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_P):
		if visible:
			close()
		else:
			open()
		get_viewport().set_input_as_handled()

func _on_resume_pressed() -> void:
	close()

func _on_restart_pressed() -> void:
	get_tree().paused = false
	var global = get_node_or_null("/root/Global")
	if global:
		global.score = 0
	get_tree().reload_current_scene()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main.tscn")
