extends CanvasLayer

var score: int
var time: int


func _ready():
	get_tree().paused = true

	if not score:
		score = 0

	if not time:
		time = 0

	var score_str = "Score: %d"
	$HBoxContainer/VBoxContainer/Score.text = score_str % score

	var time_str = "Time: %02d:%02d"
	var time_min = floor(time / 60.0)
	var time_sec = time % 60
	$HBoxContainer/VBoxContainer/Time.text = time_str % [time_min, time_sec]


func _on_Button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	get_tree().get_root().propagate_call("clear")
	queue_free()
