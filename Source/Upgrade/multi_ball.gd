extends "res://Source/Upgrade/Base_Upgrade.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func on_upgrade():
	#double ball count, halve ball size
	var balls = get_tree().get_nodes_in_group("ball")
	for ballNode in balls:
		if(ballNode is CollisionShape2D):
			ballNode.shape.radius=ballNode.shape.radius/sqrt(2)
			pass
		if(ballNode is AnimatedSprite):
			ballNode.scale=ballNode.scale/sqrt(2)
	for ball in balls:
		if(ball is RigidBody2D):
			ball.get_parent().add_child(ball.duplicate())

	.on_upgrade()
