extends Area2D
export var distance = 500


func _ready():
	pass


func _physics_process(_delta):
	pass


func _on_Panel_body_entered(body):
	if body.is_in_group("ball"):
		var v = body.linear_velocity
		v = v.reflect(Vector2(0, 1).rotated(rotation))
		if v.length() == 0:
			v = body.speed * Vector2(1, 0).rotated(rotation)
		body.linear_velocity = v
