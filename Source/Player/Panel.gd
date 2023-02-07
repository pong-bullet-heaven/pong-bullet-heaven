extends Area2D
export var distance=500

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _physics_process(delta):
	pass
	



func _on_Panel_body_entered(body):
	if(body.is_in_group("ball")):
		var v=body.linear_velocity
		v=v.reflect(Vector2(0,1).rotated(rotation))
		if(v.length()==0):
			v=body.speed*Vector2(1,0).rotated(rotation)
		body.linear_velocity=v			


