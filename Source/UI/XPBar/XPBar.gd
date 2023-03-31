extends TextureProgress

func _process(delta):
	value = Player.xp
	max_value = Player.xp_needed
