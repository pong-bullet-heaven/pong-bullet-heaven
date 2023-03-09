extends RigidBody2D
export var base_speed=1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var speed = base_speed+Player.get_upgrade_level("ball_speed")*1000
	if(Input.is_action_just_pressed("action")):		
		$CollisionShape2D.disabled=true
		
	if(Input.is_action_just_released("action")):
		$CollisionShape2D.disabled=false
		if(Player.position.distance_to(position)<300):
			linear_velocity = Vector2(0,1).rotated(Player.rotation)*speed
			
	if(Input.is_action_pressed("action")):		
		var target=Player.position+Vector2(0,1).rotated(Player.rotation)*200
		var v=target-position
		if(Player.position.distance_to(position)<300):
			linear_velocity = v*10
		else:
			linear_velocity += v*(1/v.length()) * speed/10
		
		
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
		_on_bounce()
	if(position.x>borderR):
		position.x=borderR
		linear_velocity.x=-abs(linear_velocity.x)
		_on_bounce()
	if(position.y<borderU):
		position.y=borderU
		linear_velocity.y=abs(linear_velocity.y)
		_on_bounce()
	if(position.y>borderD):
		position.y=borderD
		linear_velocity.y=-abs(linear_velocity.y)
		_on_bounce()
		
	
func in_borders(node):
	var visibleRectGlobal: Rect2 = get_viewport_transform().affine_inverse().xform(get_viewport_rect())
	var borderL=visibleRectGlobal.position.x
	var borderR=visibleRectGlobal.end.x
	var borderU=visibleRectGlobal.position.y
	var borderD=visibleRectGlobal.end.y
	if(node.position.x<borderL):
		return false
	if(node.position.x>borderR):
		return false		
	if(node.position.y<borderU):
		return false
	if(node.position.y>borderD):
		return false
	return true
	
func home_on_enemy(ignore):
	var n=0
	match(Player.get_upgrade_level("homing")):
		1:n=5
		2:n=15
		3:n=30
	var space_state = get_world_2d().direct_space_state
	
	var closest
	var distance_to_closest=INF
	UI.clear_debug_lines("ball_bounce")
	for i in range(-n,n+1):
		var vector= linear_velocity.rotated(deg2rad(i))*100
		var result = space_state.intersect_ray(position, vector)
		UI.draw_debug_line("ball_bounce",position,vector)
		if(result.has("collider")):
			result=result.get("collider")
			if(result.is_in_group("Enemy" )or result==Player and result!=ignore):
				var distance=position.distance_to(result.position)
				if(distance<distance_to_closest and in_borders(result)):
					closest=result
					distance_to_closest=distance
	if(closest!=null):
		print(closest)
		linear_velocity = position.direction_to(closest.position)*linear_velocity.length()
		UI.draw_debug_line("ball_bounce",position,closest.position,Color.red)
		
		
func _on_Ball_body_entered(body):
	pass


func _on_Ball_body_exited(body):
	
	if(body.is_in_group("Enemy")):
		body.damage(1+Player.get_upgrade_level("damage"))
		
	_on_bounce(body)
	
			
func _on_bounce(target=null):	
	if(Player.get_upgrade_level("homing")>0):		
		home_on_enemy(target)
	pass
		


