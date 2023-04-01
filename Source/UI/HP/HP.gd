extends TextureRect

var one_hp = preload("res://Assets/Images/UI/HP/hp-01.png")
var two_hp = preload("res://Assets/Images/UI/HP/hp-02.png")
var three_hp = preload("res://Assets/Images/UI/HP/hp-03.png")
var four_hp = preload("res://Assets/Images/UI/HP/hp-04.png")
var five_hp = preload("res://Assets/Images/UI/HP/hp-05.png")


func _process(_delta):
	var texture
	if Player.health == 5:
		texture = five_hp
	elif Player.health == 4:
		texture = four_hp
	elif Player.health == 3:
		texture = three_hp
	elif Player.health == 2:
		texture = two_hp
	elif Player.health == 1:
		texture = one_hp
	self.texture = texture
