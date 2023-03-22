extends Area2D


func _ready():
	pass


func _physics_process(_delta):
	pass


func _on_Paddle_body_entered(body):
	if body.is_in_group("ball"):
		var v = body.linear_velocity
		var reflection_axis = Player.rotation - PI / 2
		if v.angle_to(Vector2(0, 1).rotated(reflection_axis)) > 0:  #check if collision is from front
			v = v.reflect(Vector2(0, 1).rotated(reflection_axis))
			if v.length() == 0:
				v = body.speed * Vector2(1, 0).rotated(reflection_axis)
			v = v + v.normalized() * 1000
			body.linear_velocity = v
		body.on_bounce(Player)
