extends CanvasLayer

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		toggle_fullscreen()

func toggle_fullscreen():
	if (OS.window_fullscreen):
		var screen = OS.get_screen_size()
		var base = Vector2(1024, 576)
		var div = screen / base
		OS.window_size = floor(min(div[0], div[1])) * base
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true
