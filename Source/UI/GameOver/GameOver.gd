extends CanvasLayer

var score: int
var time: int


func _ready():
	UI.ui_occupied = true
	get_tree().paused = true

	if not time:
		time = 0

	var time_str = "[center]%02d:%02d[/center]"
	var time_min = floor(time / 60.0)
	var time_sec = time % 60
	$Background/Time.bbcode_text = time_str % [time_min, time_sec]

	if not score:
		score = 0

	var score_str = """[center]Score
%05d[/center]"""
	$Background/Score.bbcode_text = score_str % score


func highlight_btn(state: bool):
	if state:
		$Background/CenterButton/Button.theme.default_font.outline_size = 4
	else:
		$Background/CenterButton/Button.theme.default_font.outline_size = 2


func _on_Button_pressed():
	$Background/CenterButton/Button.theme.default_font.outline_size = 2
	get_tree().paused = false
	get_tree().reload_current_scene()
	get_tree().get_root().propagate_call("clear")
	UI.ui_occupied = false
	queue_free()


func _on_Button_focus_entered():
	highlight_btn(true)


func _on_Button_mouse_entered():
	highlight_btn(true)


func _on_Button_focus_exited():
	highlight_btn(false)


func _on_Button_mouse_exited():
	highlight_btn(false)
