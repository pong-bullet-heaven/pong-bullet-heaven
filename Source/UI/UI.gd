extends CanvasLayer

export var audio_idx: int
var menu


func _ready():
	_setup()


func clear():
	_setup()


func _setup():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	audio_idx = AudioServer.get_bus_index("Master")
	menu = load("res://Source/UI/Menu/Menu.tscn").instance()
	menu.set_sound(true)
	menu.set_fullscreen(true)
	custom_cursor()
	toggle_menu()


func _process(_delta):
	if Input.is_action_just_pressed("toggle_menu"):
		toggle_menu()

	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen()

	if Input.is_action_just_pressed("toggle_sound"):
		toggle_sound()


func _input(event):
	if event is InputEventMouseMotion:
		$Control/MouseCursor.position = event.position
	elif event is InputEventMouseButton:
		if event.pressed:
			$Control/MouseCursor.animation = "click"
		else:
			$Control/MouseCursor.animation = "default"


func custom_cursor():
	var size = round(OS.window_size.y / 67.5)
	var sprite_scale = $Control/MouseCursor.scale
	if sprite_scale >= Vector2(1, 1):
		var sprite_frame = $Control/MouseCursor.frames.get_frame("default", 0)
		var sprite_size = sprite_frame.get_size()
		var scale = Vector2(
			sprite_scale.x / (sprite_size.x / size), sprite_scale.y / (sprite_size.y / size)
		)
		$Control/MouseCursor.scale = scale


func toggle_menu():
	if menu.get_parent():
		get_tree().paused = false
		UI.call_deferred("remove_child", menu)
	else:
		get_tree().paused = true
		UI.call_deferred("add_child", menu)


func toggle_fullscreen():
	if OS.window_fullscreen:
		var screen_size = OS.get_screen_size()
		var base = Vector2(
			ProjectSettings.get_setting("display/window/size/width"),
			ProjectSettings.get_setting("display/window/size/height")
		)
		var div = screen_size / base
		var window_size = base * floor(min(div[0], div[1]))
		OS.window_size = window_size
		OS.window_fullscreen = false
		OS.set_window_position(0.5 * screen_size - 0.5 * window_size)
		menu.set_fullscreen(false)
	else:
		OS.window_fullscreen = true
		menu.set_fullscreen(true)


func toggle_sound():
	if AudioServer.is_bus_mute(audio_idx):
		AudioServer.set_bus_mute(audio_idx, false)
		menu.set_sound(true)
	else:
		AudioServer.set_bus_mute(audio_idx, true)
		menu.set_sound(false)
