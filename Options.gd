extends Button

@onready var spawn_interval = Global.spawn_interval
@onready var nbre_clicks = Global.nbre_clicks
@onready var difficultGame : Button = $"."
@onready var optionsMusic : Button = $"../MusicOptions"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_DifficultGame_pressed() -> void:

	nbre_clicks += 1
	
	if nbre_clicks == 1 :
		difficultGame.text = "Difficulté du jeu : 1"
		Global.spawn_interval = 1.5
	if nbre_clicks == 2 :
		difficultGame.text = "Difficulté du jeu : 2"
		Global.spawn_interval = 1.7
	if nbre_clicks == 3 :
		difficultGame.text = "Difficulté du jeu : 3"
		Global.spawn_interval = 1.9
	if nbre_clicks > Global.max_clicks:
		nbre_clicks = 0
		difficultGame.text = "Difficulté du jeu : 0"
		Global.spawn_interval = 1.3
	
	pass # Replace with function body.
	

func _on_Music_pressed() -> void:
	pass # Replace with function body.
	
func _on_Retour_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
	pass # Replace with function body.
