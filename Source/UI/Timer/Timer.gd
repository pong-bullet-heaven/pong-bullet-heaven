extends RichTextLabel

var enabled = true


func _process(delta):
	if !UI.is_occupied():
		Player.timer += delta

	if enabled:
		var timer = Player.timer
		var timer_template = "[center]%02d : %02d[/center]"
		var m = floor(timer / 60.0)
		var s = fmod(timer, 60)
		self.bbcode_text = timer_template % [m, s]
