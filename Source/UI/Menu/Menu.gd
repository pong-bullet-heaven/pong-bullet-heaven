extends HBoxContainer

var ui = UI.get_child(0)

var fullscreen_on = preload("res://Assets/Images/Icons/Fullscreen/maximize.tres")
var fullscreen_off = preload("res://Assets/Images/Icons/Fullscreen/minimize.tres")
var volume_on = preload("res://Assets/Images/Icons/Volume/volume-on.tres")
var volume_off = preload("res://Assets/Images/Icons/Volume/volume-off.tres")


func _on_Play_pressed():
	ui.toggle_menu()


func _on_Credits_pressed():
	OS.shell_open("https://github.com/pong-bullet-heaven/pong-bullet-heaven#readme")


func _on_Quit_pressed():
	get_tree().quit()


func _on_Fullscreen_pressed():
	ui.toggle_fullscreen()


func _on_Sound_pressed():
	ui.toggle_sound()


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
