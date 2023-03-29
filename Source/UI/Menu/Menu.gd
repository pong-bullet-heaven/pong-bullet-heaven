extends CanvasLayer

var fullscreen_on = preload("res://Assets/Images/Icons/Fullscreen/maximize.tres")
var fullscreen_off = preload("res://Assets/Images/Icons/Fullscreen/minimize.tres")
var volume_on = preload("res://Assets/Images/Icons/Volume/volume-on.tres")
var volume_off = preload("res://Assets/Images/Icons/Volume/volume-off.tres")


func _on_Play_pressed():
	UI.toggle_menu()


func _on_Credits_pressed():
	OS.shell_open("https://github.com/pong-bullet-heaven/pong-bullet-heaven#readme")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Fullscreen_pressed():
	UI.toggle_fullscreen()


func _on_Sound_pressed():
	UI.toggle_sound()


func set_fullscreen(state: bool):
	var txt = "Fullscreen"
	if state:
		$HBoxContainer/VBoxContainer/Fullscreen.text = txt + ": On"
	else:
		$HBoxContainer/VBoxContainer/Fullscreen.text = txt + ": Off"


func set_sound(state: bool):
	var txt = "Sound"
	if state:
		$HBoxContainer/VBoxContainer/Sound.text = txt + ": On"
	else:
		$HBoxContainer/VBoxContainer/Sound.text = txt + ": Off"
