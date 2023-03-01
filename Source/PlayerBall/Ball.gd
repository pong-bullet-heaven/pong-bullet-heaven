extends RigidBody2D
export var base_speed=1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	#linear_velocity=linear_velocity.normalized()*speed #constant speed
	var speed = base_speed+Player.get_upgrade_level("ball_speed")*1000
	#print(speed)
	if(linear_velocity.length()>speed): #maxspeed for variable velocity
		linear_velocity=linear_velocity.normalized()*speed
		
	var visibleRectGlobal: Rect2 = get_viewport_transform().affine_inverse().xform(get_viewport_rect())
	var borderL=visibleRectGlobal.position.x
	var borderR=visibleRectGlobal.end.x
	var borderU=visibleRectGlobal.position.y
	var borderD=visibleRectGlobal.end.y
	if(position.x<borderL):
		position.x=borderL
		linear_velocity.x=abs(linear_velocity.x)
	if(position.x>borderR):
		position.x=borderR
		linear_velocity.x=-abs(linear_velocity.x)
	if(position.y<borderU):
		position.y=borderU
		linear_velocity.y=abs(linear_velocity.y)
	if(position.y>borderD):
		position.y=borderD
		linear_velocity.y=-abs(linear_velocity.y)
	
func _on_Ball_body_entered(body):
	if(body.is_in_group("Enemy")):
		body.damage(1+Player.get_upgrade_level("damage"))
		

