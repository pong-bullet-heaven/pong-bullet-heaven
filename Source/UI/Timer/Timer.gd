extends RichTextLabel


var time = 0
var timer_on = true

func _process(delta):
	if(timer_on):
		time += delta
		text = var2str(time)
#no hours added, i dont think anyone will ever last that long
	var seconds = fmod(time,60)
	var minutes = fmod(time, 60*60) / 60
	
	var time_passed = "%02d : %02d" % [minutes,seconds]
	text = time_passed
	
	Player.timer = time
