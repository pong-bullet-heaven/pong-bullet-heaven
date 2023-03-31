extends HBoxContainer

var five_hp = preload("res://Assets/Images/UI/HP/HP_5.png")
var four_hp = preload("res://Assets/Images/UI/HP/HP_4.png")
var three_hp = preload("res://Assets/Images/UI/HP/HP_3.png")
var two_hp = preload("res://Assets/Images/UI/HP/HP_2.png")
var one_hp = preload("res://Assets/Images/UI/HP/HP_1.png")

func _ready():
	 pass


func _process(delta):
	if Player.health == 5:
		$HP.texture = five_hp
	elif Player.health == 4:
		$HP.texture =  four_hp
	elif Player.health == 3:
		$HP.texture =  three_hp
	elif Player.health == 2:
		$HP.texture =  two_hp
	elif Player.health == 1:
		$HP.texture =  one_hp
