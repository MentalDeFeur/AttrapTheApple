extends SceneTree

func _init() -> void:
	print("--- Starting Automated Tests for AttrapTheApple ---")
	
	# Test 1: Load and instantiate PauseMenu
	print("Test 1: Testing PauseMenu...")
	var pause_scene = load("res://PauseMenu.tscn")
	assert(pause_scene != null, "Failed to load PauseMenu.tscn")
	var pause_menu = pause_scene.instantiate()
	root.add_child(pause_menu)
	assert(pause_menu.has_method("open"), "PauseMenu missing open()")
	assert(pause_menu.has_method("close"), "PauseMenu missing close()")
	pause_menu.open()
	assert(paused == true, "PauseMenu open() did not pause the tree")
	assert(pause_menu.visible == true, "PauseMenu open() did not show the menu")
	paused = false
	pause_menu.queue_free()
	print("Test 1 Passed!")

	# Test 2: Load and instantiate Apple
	print("Test 2: Testing Apple and Poison Apple...")
	var apple_scene = load("res://Apple.tscn")
	assert(apple_scene != null, "Failed to load Apple.tscn")
	var apple = apple_scene.instantiate()
	root.add_child(apple)
	var apple_body = apple.get_node_or_null("Area2D/Apple")
	assert(apple_body != null, "Area2D/Apple not found")
	assert(apple_body.has_method("set_as_poison"), "Apple missing set_as_poison()")
	assert(apple_body.has_method("collect"), "Apple missing collect()")
	
	# Test poison toggle
	apple_body.set_as_poison()
	assert(apple_body.is_poison == true, "is_poison should be true after set_as_poison()")
	
	# Test collect
	apple_body.collect()
	assert(apple_body.is_collected == true, "is_collected should be true after collect()")
	print("Test 2 Passed!")

	# Test 3: Load and instantiate Game.tscn
	print("Test 3: Testing Game scene nodes...")
	var game_scene = load("res://Game.tscn")
	assert(game_scene != null, "Failed to load Game.tscn")
	var game = game_scene.instantiate()
	root.add_child(game)
	
	assert(game.has_node("PauseMenu"), "Game missing PauseMenu node")
	assert(game.has_node("CatchSfx"), "Game missing CatchSfx node")
	assert(game.has_node("BtnPause"), "Game missing BtnPause button")
	assert(game.has_node("Character"), "Game missing Character node")
	
	var character = game.get_node("Character")
	assert(character.has_method("play_catch_bounce"), "Character missing play_catch_bounce()")
	assert(character.has_method("play_hurt_effect"), "Character missing play_hurt_effect()")
	
	character.play_catch_bounce()
	character.play_hurt_effect()
	
	print("Test 3 Passed!")
	
	print("--- All Automated Tests Passed Successfully! ---")
	quit(0)
