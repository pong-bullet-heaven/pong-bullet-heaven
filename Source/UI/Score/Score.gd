extends RichTextLabel


func _process(_delta):
	var score_template = "[right]Score: %05d[/right]"
	self.bbcode_text = score_template % Player.score
