extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label/AnimationPlayer.play("zoom_in")
	$VBoxContainer/Button/AnimationPlayer.play("zoom_in")
	$VBoxContainer/Button2/AnimationPlayer.play("zoom_in")
	$VBoxContainer/Button3/AnimationPlayer.play("zoom_in")
	$MusicBG.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_Play_pressed() -> void:
	get_tree().change_scene_to_file("res://Game.tscn")
	pass # Replace with function body.

func _on_Options_pressed() -> void:
	get_tree().change_scene_to_file("res://Options.tscn")
	pass # Replace with function body.

func _on_Credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Credits.tscn")
	pass # Replace with function body.
