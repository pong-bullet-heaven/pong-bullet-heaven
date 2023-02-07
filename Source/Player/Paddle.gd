extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	pass
	
func _on_Paddle_body_entered(body):	
	if(body.is_in_group("ball")):
		var v=body.linear_velocity
		var reflectionAxis=Player.rotation-PI/2
		if(v.angle_to(Vector2(0,1).rotated(reflectionAxis))>0):#check if collision is from front
			v=v.reflect(Vector2(0,1).rotated(reflectionAxis))
			if(v.length()==0):
				v=body.speed*Vector2(1,0).rotated(reflectionAxis)
			v=v+v.normalized()*1000
			body.linear_velocity=v


