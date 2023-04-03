extends CanvasLayer

var scene_ball = preload("res://Source/Ball/Ball.tscn")


func clear():
	queue_free()


func spawn_ball_if_none():
	var main = get_tree().root.get_node("Main")
	if get_tree().get_nodes_in_group("Ball").empty():
		var ball = scene_ball.instance()
		ball.get_node("CollisionShape2D").shape.radius = ball.base_collision_radius
		ball.get_node("AnimatedSprite").scale = ball.base_sprite_scale
		main.add_child(ball)


func _on_Play_pressed():
	spawn_ball_if_none()
	UI.toggle_menu()
	UI.ui_visible(true)


func _on_Credits_pressed():
	OS.shell_open("https://github.com/pong-bullet-heaven/pong-bullet-heaven#readme")


func _on_Quit_pressed():
	if OS.get_name() == "HTML5" && OS.has_feature("JavaScript"):
		JavaScript.eval("open(location, '_self').close()")
	else:
		get_tree().quit()


func _on_Fullscreen_pressed():
	UI.toggle_fullscreen()


func _on_FPS_pressed():
	UI.toggle_fps()


func _on_Sound_pressed():
	UI.toggle_sound()


func set_fullscreen(state: bool):
	var txt = "Fullscreen"
	if state:
		$CenterContainer/VBoxContainer/Fullscreen.text = txt + ": On"
	else:
		$CenterContainer/VBoxContainer/Fullscreen.text = txt + ": Off"


func set_fps(state: bool):
	var txt = "FPS"
	if state:
		$CenterContainer/VBoxContainer/FPS.text = txt + ": On"
	else:
		$CenterContainer/VBoxContainer/FPS.text = txt + ": Off"


func set_sound(state: bool):
	var txt = "Sound"
	if state:
		$CenterContainer/VBoxContainer/Sound.text = txt + ": On"
	else:
		$CenterContainer/VBoxContainer/Sound.text = txt + ": Off"
