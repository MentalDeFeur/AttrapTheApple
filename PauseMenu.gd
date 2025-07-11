extends CanvasLayer


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if get_tree().paused:
			resume_game()
		else: 
			pause_game()

func pause_game():
	visible = true
	get_tree().paused = true
	process_mode = Node.PROCESS_MODE_ALWAYS

func resume_game():
	visible = false
	get_tree().paused = false

func _on_resume_button_pressed() -> void:
	resume_game()
	pass # Replace with function body.


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Main.tscn")
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.



	
