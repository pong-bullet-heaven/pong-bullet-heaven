extends CanvasLayer

var scene_ball = preload("res://Source/Ball/Ball.tscn")


func clear():
	queue_free()


func _on_Play_pressed():
	var main = get_tree().root.get_node("/root/Main")
	if !main.get_node_or_null("Ball"):
		var ball = scene_ball.instance()
		main.add_child(ball)
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
