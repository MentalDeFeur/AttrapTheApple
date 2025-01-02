extends CanvasLayer

@onready var resume_button = $ResumeButton
@onready var quit_button = $QuitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resume_button.pressed.connect(_on_Resume_pressed())
	quit_button.pressed.connect(_on_Quit_pressed())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_Resume_pressed():
	get_tree().paused = false
	self.visible = false
	
func _on_Quit_pressed():
	get_tree().quit()
