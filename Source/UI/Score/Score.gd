extends RichTextLabel


func _process(delta):
		
		var scoretext = "Score: " + "%s" %[Player.score]
		self.text = scoretext
	
