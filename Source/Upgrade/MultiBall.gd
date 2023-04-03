extends "BaseUpgrade.gd"


func on_upgrade():
	#double ball count, halve ball size
	var balls = get_tree().get_nodes_in_group("Ball")
	for ball_node in balls:
		if ball_node is CollisionShape2D:
			ball_node.shape.radius = ball_node.shape.radius / sqrt(2)
		if ball_node is AnimatedSprite:
			ball_node.scale = ball_node.scale / sqrt(2)
	for ball in balls:
		if ball is RigidBody2D:
			ball.get_parent().add_child(ball.duplicate())
	.on_upgrade()
