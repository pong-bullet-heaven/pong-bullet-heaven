extends CanvasLayer

var audio_idx: int
var menu
var menu_reset: bool
var occupied: bool

var scene_menu = preload("res://Source/UI/Menu/Menu.tscn")


func _ready():
	_setup()
	toggle_fps()


func clear():
	_setup()


func _setup():
	audio_idx = AudioServer.get_bus_index("Master")
	menu = scene_menu.instance()
	menu.set_sound(!AudioServer.is_bus_mute(audio_idx))
	menu.set_fps($HBoxContainerBottomLeft/FPS.visible)
	menu.set_fullscreen(OS.window_fullscreen)
	mouse_mode()
	custom_cursor()
	toggle_menu()
	menu_reset = true
	UI.ui_visible(false)


func _process(_delta):
	if Input.is_action_just_pressed("toggle_menu") && !menu_reset:
		toggle_menu()

	if Input.is_action_just_pressed("toggle_fullscreen"):
		toggle_fullscreen()

	if Input.is_action_just_pressed("toggle_fps"):
		toggle_fps()

	if Input.is_action_just_pressed("toggle_sound"):
		toggle_sound()

	if $HBoxContainerBottomLeft/FPS.visible:
		$HBoxContainerBottomLeft/FPS.text = "FPS: %d" % Engine.get_frames_per_second()


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
		if OS.get_name() == "HTML5":
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		else:
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
		ui_occupied(false)
		get_tree().paused = false
		UI.call_deferred("remove_child", menu)
	elif !is_occupied():
		ui_occupied(true)
		get_tree().paused = true
		UI.call_deferred("add_child", menu)
	menu_reset = false


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


func toggle_fps():
	var fps = $HBoxContainerBottomLeft/FPS
	fps.visible = !fps.visible
	menu.set_fps(fps.visible)


func toggle_sound():
	if AudioServer.is_bus_mute(audio_idx):
		AudioServer.set_bus_mute(audio_idx, false)
	else:
		AudioServer.set_bus_mute(audio_idx, true)
	menu.set_sound(!AudioServer.is_bus_mute(audio_idx))


func ui_visible(state: bool):
	$HBoxContainerTopLeft/HP.visible = state
	$HBoxContainerTopCenter/Timer.visible = state
	$HBoxContainerTopRight/Score.visible = state
	$HBoxContainerBottomCenter/XPBar.visible = state
	# $HBoxContainerBottomLeft/FPS.visible = state


func is_occupied():
	return occupied


func ui_occupied(state: bool):
	occupied = state
	set_modulate()


func set_modulate():
	var modulate_bg
	var modulate_fg
	if is_occupied():
		modulate_bg = 128.0 / 255.0
		modulate_fg = 192.0 / 255.0
	else:
		modulate_bg = 192.0 / 255.0
		modulate_fg = 255.0 / 255.0

	var color_bg = Color(modulate_bg, modulate_bg, modulate_bg, 1)
	var color_fg = Color(modulate_fg, modulate_fg, modulate_fg, 1)

	get_tree().root.get_node("/root/Player").modulate = color_fg
#	get_tree().root.get_node("/root/Main/Ball").modulate = color_fg
	get_tree().root.get_node("/root/Main/EnemyController").modulate = color_fg
	var bg_path = "/root/Main/ParallaxBackground/ParallaxLayer/Background"
	get_tree().root.get_node(bg_path).modulate = color_bg
