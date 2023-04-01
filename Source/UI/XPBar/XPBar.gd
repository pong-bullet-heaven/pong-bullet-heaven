extends TextureProgress


func _process(_delta):
	value = Player.xp
	max_value = Player.xp_needed
