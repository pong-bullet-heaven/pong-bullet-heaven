extends "res://Source/Upgrade/Base_Upgrade.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_upgrade():
	Player.get_node("XPCollector/CollisionShape2D").shape.radius=Player.get_node("XPCollector/CollisionShape2D").shape.radius*1.4
	.on_upgrade()
