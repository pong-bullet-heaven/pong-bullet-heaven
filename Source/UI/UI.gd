extends CanvasLayer

func _ready():
	pass

func _process(_delta):
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		toggle_fullscreen()

func toggle_fullscreen():
	if (OS.window_fullscreen):
		var screen_size = OS.get_screen_size()
		var base = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))
		var div = screen_size / base
		var window_size = base * floor(min(div[0], div[1]))
		OS.window_size = window_size
		OS.window_fullscreen = false
		OS.set_window_position(0.5 * screen_size - 0.5 * window_size)
	else:
		OS.window_fullscreen = true
