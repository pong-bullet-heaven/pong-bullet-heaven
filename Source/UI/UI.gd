extends CanvasLayer

export var ui_occupied: bool
export var audio_idx: int
var menu
var show_fps = false
var scene_menu = preload("res://Source/UI/Menu/Menu.tscn")


func _ready():
	_setup()


func clear():
	_setup()


func _setup():
	audio_idx = AudioServer.get_bus_index("Master")
	menu = scene_menu.instance()
	menu.set_sound(!AudioServer.is_bus_mute(audio_idx))
	menu.set_fullscreen(OS.window_fullscreen)
	mouse_mode()
	custom_cursor()
	toggle_menu()
	UI.ui_visible(false)


func _process(_delta):
	if Input.is_action_just_pressed("toggle_menu"):
		toggle_menu()

	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen()

	if Input.is_action_just_pressed("toggle_sound"):
		toggle_sound()

	if show_fps:
		$Fps.set_text("FPS " + String(Engine.get_frames_per_second()))
	else:
		$Fps.set_text("")


func _input(event):
	if event is InputEventMouseMotion:
		$Dummy/MouseCursor.position = event.position
	elif event is InputEventMouseButton:
		if event.pressed:
			$Dummy/MouseCursor.animation = "click"
		else:
			$Dummy/MouseCursor.animation = "default"


func mouse_mode():
	if OS.window_fullscreen:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)


func custom_cursor():
	var size = round(OS.window_size.y / 67.5)
	var sprite_scale = $Dummy/MouseCursor.scale
	if sprite_scale >= Vector2(1, 1):
		var sprite_frame = $Dummy/MouseCursor.frames.get_frame("default", 0)
		var sprite_size = sprite_frame.get_size()
		var scale = Vector2(
			sprite_scale.x / (sprite_size.x / size), sprite_scale.y / (sprite_size.y / size)
		)
		$Dummy/MouseCursor.scale = scale


func toggle_menu():
	if menu.get_parent():
		ui_occupied = false
		get_tree().paused = false
		UI.call_deferred("remove_child", menu)
	elif !ui_occupied:
		ui_occupied = true
		get_tree().paused = true
		UI.call_deferred("add_child", menu)


func ui_visible(state: bool):
	$HBoxContainerTopRight/Score.visible = state
	$HBoxContainerTopCenter/Timer.visible = state


func toggle_fullscreen():
	# disable in macos due to scaling issues with hidpi
	if OS.get_name() == "OSX":
		return

	if OS.window_fullscreen:
		var screen_size = OS.get_screen_size()
		var base = Vector2(
			ProjectSettings.get_setting("display/window/size/width"),
			ProjectSettings.get_setting("display/window/size/height")
		)
		# calculation is too complex and introduces unexpected behavior
		# just use base viewport size as new window size
		#var div = screen_size / base
		#var window_size = base * floor(min(div[0], div[1]))
		var window_size = base
		OS.window_size = window_size
		OS.window_fullscreen = false
		OS.set_window_position(0.5 * screen_size - 0.5 * window_size)
	else:
		OS.window_fullscreen = true
	mouse_mode()
	menu.set_fullscreen(OS.window_fullscreen)


func toggle_sound():
	if AudioServer.is_bus_mute(audio_idx):
		AudioServer.set_bus_mute(audio_idx, false)
	else:
		AudioServer.set_bus_mute(audio_idx, true)
	menu.set_sound(!AudioServer.is_bus_mute(audio_idx))
