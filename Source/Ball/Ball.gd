extends RigidBody2D
export var base_speed=1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func get_borders():
	var offset = $CollisionShape2D.shape.radius
	var window_size = get_viewport_rect().size
	var window_size_half_x = window_size[0] / 2 - offset
	var window_size_half_y = window_size[1] / 2 - offset
	var player_position_x = Player.position[0]
	var player_position_y = Player.position[1]

	return {
		"bottom": player_position_y + window_size_half_y,
		"left": player_position_x - window_size_half_x,
		"right": player_position_x + window_size_half_x,
		"top": player_position_y - window_size_half_y
	}

func _physics_process(_delta):
	var speed = base_speed+Player.get_upgrade_level("ball_speed")*1000
	if(Input.is_action_just_pressed("action")):
		set_collision_mask_bit(1, false)

	if(Input.is_action_just_released("action")):
		set_collision_mask_bit(1, true)
		if(Player.position.distance_to(position)<300):
			linear_velocity = Vector2(0,1).rotated(Player.rotation)*speed

	if(Input.is_action_pressed("action")):
		var target=Player.position+Vector2(0,1).rotated(Player.rotation)*200
		var v=target-position
		if(Player.position.distance_to(position)<300):
			linear_velocity = v*10
		else:
			linear_velocity += v*(1/v.length()) * speed/10


	if(linear_velocity.length() > speed): #maxspeed for variable velocity
		linear_velocity = linear_velocity.normalized() * speed

	var borders = get_borders()

	if(position.y > borders.bottom):
		position.y = borders.bottom
		linear_velocity.y = -abs(linear_velocity.y)
		_on_bounce()
	if(position.x < borders.left):
		position.x = borders.left
		linear_velocity.x = abs(linear_velocity.x)
		_on_bounce()
	if(position.x > borders.right):
		position.x = borders.right
		linear_velocity.x = -abs(linear_velocity.x)
		_on_bounce()
	if(position.y < borders.top):
		position.y = borders.top
		linear_velocity.y = abs(linear_velocity.y)
		_on_bounce()

func in_borders(node):
	var borders = get_borders()

	if(node.position.y > borders.bottom):
		return false
	if(node.position.x < borders.left):
		return false
	if(node.position.x > borders.right):
		return false
	if(node.position.y < borders.top):
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
			if(result.is_in_group("Enemy" ) and result!=ignore):#or result==Player):
				var distance=position.distance_to(result.position)
				if(distance<distance_to_closest and in_borders(result)):
					closest=result
					distance_to_closest=distance
	if(closest!=null):
		print(closest)
		linear_velocity = position.direction_to(closest.position)*linear_velocity.length()
		UI.draw_debug_line("ball_bounce",position,closest.position,Color.red)

func _on_Ball_body_entered(_body):
	pass

func _on_Ball_body_exited(body):

	if(body.is_in_group("Enemy")):
		body.damage(1+Player.get_upgrade_level("damage"))

	_on_bounce(body)

func _on_bounce(target=null):
	if(Player.get_upgrade_level("homing")>0):
		home_on_enemy(target)
	pass
