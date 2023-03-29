extends KinematicBody2D

export var health = 20
export var invincible_seconds = 0
var base_speed = 500
var xp = 0
var xp_needed = 1
var level = 0

var direction = "n"


func _process(_delta):
	var animation = direction + "_walk"
	if invincible_seconds > 0:
		animation = "damage"
	$AnimatedSpriteCharacter.play(animation)
	$AnimatedSpriteCharacter.rotation = -rotation
	if abs(rotation) < PI / 2:
		$Paddle/AnimatedSpritePaddle.z_index = 11
	else:
		$Paddle/AnimatedSpritePaddle.z_index = 9

	if xp >= xp_needed:
		on_level_up()


func _physics_process(delta):
	invincible_seconds = max(invincible_seconds - delta, 0)
	var speed = base_speed + 100 * get_upgrade_level("speed")
	if Input.is_action_pressed("action"):
		match Player.get_upgrade_level("pulse_movement"):
			0:
				speed = 0
			1:
				speed = speed * 0.5
			3:
				speed = speed * 1.5

	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if v.length() > 0:
		v = v.normalized() * speed
	var dir_vec = Vector2(0, 1).rotated(rotation + PI / 4)
	#var dir_vec=v.rotated(PI/4)
	if dir_vec[0] < 0:
		if dir_vec[1] < 0:
			direction = "l"
		if dir_vec[1] > 0:
			direction = "f"
	if dir_vec[0] > 0:
		if dir_vec[1] < 0:
			direction = "b"
		if dir_vec[1] > 0:
			direction = "r"
	if v == Vector2(0, 0):
		direction = "n"

	v = move_and_slide(v)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Enemy"):
			player_hit(collider.collision_damage)

	if health <= 0:
		pass


func _input(event):  #turn to mouse
	if event is InputEventMouseMotion:
		var vec = event.position / get_viewport_rect().size - Vector2(0.5, 0.5)
		rotation = vec.angle() - PI / 2


func _on_XPCollector_area_entered(area):
	$XPSound.play()
	if area.is_in_group("collectable"):
		area.caught = true


func player_hit(damage):
	if invincible_seconds == 0:
		health -= damage
		invincible_seconds = 0.5
		# print(health)
	if health <= 0:
		die()


func on_level_up():
	var lvlup = load("res://Source/UI/LvlUp/LvlUp.tscn")
	xp -= xp_needed
	level += 1
	xp_needed = 5 * level
	# print("lvl up")
	UI.add_child(lvlup.instance())


func get_upgrade_level(name):
	var node = $Upgrades.get_node(name)
	return node.level


func get_available_upgrades():
	var available = []
	for upgrade in $Upgrades.get_children():
		if _filter_upgrade(upgrade):
			available.append(upgrade)
	return available


func _filter_upgrade(upgrade):
	if upgrade.level >= upgrade.max_level:
		return false
	if upgrade.required_level > level:
		return false
	for upgrade_requirement in upgrade.required_upgrades:
		var requirement_level = upgrade.required_upgrades[upgrade_requirement]
		if requirement_level > upgrade_requirement.level:
			return false
	return true


func die():
	var score = 1000
	var time = 754
	var gameover = load("res://Source/UI/GameOver/GameOver.tscn").instance()
	gameover.score = score
	gameover.time = time
	UI.add_child(gameover)
