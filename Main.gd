extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
