extends RigidBody2D
export var base_speed = 1000
var old_velocity = Vector2(0, 0)
var old_position = Vector2(0, 0)
var pierce_count = 0
var aoe_cooldown = 0

var scene_aoe = preload("res://Source/Upgrade/AoeEffect/AoeEffect.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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
	var speed = base_speed + 1000 * Player.get_upgrade_level("ball_speed")
	if Input.is_action_just_pressed("action") and not Player.dying:
		set_collision_mask_bit(1, false)

	if Input.is_action_just_released("action") and not Player.dying:
		set_collision_mask_bit(1, true)
		if Player.position.distance_to(position) < 130:
			linear_velocity = Vector2(0, 1).rotated(Player.rotation) * speed

	if Input.is_action_pressed("action") and not Player.dying:
		var target = Player.position + Vector2(0, 1).rotated(Player.rotation) * 70
		var v = target - position
		if Player.position.distance_to(position) < 130:
			linear_velocity = v * 10
		else:
			linear_velocity += v * (1 / v.length()) * speed / 10 + Vector2(1, 1) / v

	if linear_velocity.length() > speed:  #maxspeed for variable velocity
		linear_velocity = linear_velocity.normalized() * speed

	var borders = get_borders()

	if position.y > borders.bottom:
		position.y = borders.bottom
		linear_velocity.y = -abs(linear_velocity.y)
		on_bounce()
	if position.x < borders.left:
		position.x = borders.left
		linear_velocity.x = abs(linear_velocity.x)
		on_bounce()
	if position.x > borders.right:
		position.x = borders.right
		linear_velocity.x = -abs(linear_velocity.x)
		on_bounce()
	if position.y < borders.top:
		position.y = borders.top
		linear_velocity.y = abs(linear_velocity.y)
		on_bounce()

	old_velocity = linear_velocity
	old_position = position

	if aoe_cooldown > 0:
		aoe_cooldown -= _delta


func in_borders(node):
	var borders = get_borders()

	if node.position.y > borders.bottom:
		return false
	if node.position.x < borders.left:
		return false
	if node.position.x > borders.right:
		return false
	if node.position.y < borders.top:
		return false
	return true


func home_on_enemy(ignore):
	var n = 0
	match Player.get_upgrade_level("homing"):
		1:
			n = 5
		2:
			n = 15
		3:
			n = 30
	var space_state = get_world_2d().direct_space_state

	var closest
	var distance_to_closest = INF
	Debugging.clear_debug_lines("ball_bounce")
	for i in range(-n, n + 1):
		var vector = linear_velocity.rotated(deg2rad(i)) * 100
		var result = space_state.intersect_ray(position, vector)
		Debugging.draw_debug_line("ball_bounce", position, vector, Color.whitesmoke, 2)
		if result.has("collider"):
			result = result.get("collider")
			if result.is_in_group("Enemy") and result != ignore:  #or result==Player):
				var distance = position.distance_to(result.position)
				if distance < distance_to_closest and in_borders(result):
					closest = result
					distance_to_closest = distance
	if closest != null:
		linear_velocity = position.direction_to(closest.position) * linear_velocity.length()
		Debugging.draw_debug_line("ball_bounce", position, closest.position, Color.red, 2)


func _on_Ball_body_entered(body):
	if body.is_in_group("Enemy"):
		var damage: float = 1.0 + Player.get_upgrade_level("damage")
		damage = damage * pow(2.0 / 3.0, Player.get_upgrade_level("multi_ball"))
		body.damage(damage)
		on_bounce(body)


func on_bounce(target = null):
	if target != null and target.is_in_group("ball"):
		return

	#pierce
	if pierce_count > 0 and target != null and target.is_in_group("Enemy"):
		linear_velocity = old_velocity
		position = old_position
		self.add_collision_exception_with(target)
		pierce_count -= 1

	elif target != null:
		pierce_count = pow(2, Player.get_upgrade_level("piercing")) - 1  #0,1,3,7,15,31

	#aoe
	if Player.get_upgrade_level("aoe") > 0 && aoe_cooldown <= 0 && target != null:
		var aoe = scene_aoe.instance()
		aoe.position = position
		get_tree().get_root().call_deferred("add_child", aoe)
		aoe_cooldown = 0.1

	#homing
	if Player.get_upgrade_level("homing") > 0:
		home_on_enemy(target)


func _on_Area2D_body_exited(body):
	self.remove_collision_exception_with(body)
