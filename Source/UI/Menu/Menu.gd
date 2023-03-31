extends CanvasLayer


func _on_Play_pressed():
	UI.toggle_menu()


func _on_Credits_pressed():
	OS.shell_open("https://github.com/pong-bullet-heaven/pong-bullet-heaven#readme")


func _on_Quit_pressed():
	if OS.get_name() == "HTML5" && OS.has_feature("JavaScript"):
		JavaScript.eval("window.close()")
	else:
		get_tree().quit()


func _on_Fullscreen_pressed():
	UI.toggle_fullscreen()


func _on_Sound_pressed():
	UI.toggle_sound()


func set_fullscreen(state: bool):
	var txt = "Fullscreen"
	if state:
		$VBoxContainer/Fullscreen.text = txt + ": On"
	else:
		$VBoxContainer/Fullscreen.text = txt + ": Off"


func set_sound(state: bool):
	var txt = "Sound"
	if state:
		$VBoxContainer/Sound.text = txt + ": On"
	else:
		$VBoxContainer/Sound.text = txt + ": Off"
