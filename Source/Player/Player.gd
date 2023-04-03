extends KinematicBody2D

var health: int
var invincible_seconds: float
var base_speed
var xp
var xp_needed
var level
var death_seconds
var dying
var direction
var score: int
var timer: float

var scene_gameover = preload("res://Source/UI/GameOver/GameOver.tscn")
var scene_lvlup = preload("res://Source/UI/LvlUp/LvlUp.tscn")


func _ready():
	_setup()


func clear():
	_setup()


func _setup():
	health = 5
	invincible_seconds = 0.0
	base_speed = 500
	xp = 0
	xp_needed = 1
	level = 0
	direction = "not"
	score = 0
	timer = 0.0
	death_seconds = 0
	dying = false


func _process(_delta):
	var animation
	var kind

	if dying:
		kind = "death"
		if direction != "back":
			direction = "front"
	else:
		kind = "walk"

	animation = "%s_%s" % [direction, kind]

	if invincible_seconds > 0.0 && kind != "death":
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
	if dying:
		death_seconds -= delta
		if death_seconds <= 0:
			die()
		return

	invincible_seconds = float(max(invincible_seconds - delta, 0))
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
			direction = "left"
		if dir_vec[1] > 0:
			direction = "front"
	if dir_vec[0] > 0:
		if dir_vec[1] < 0:
			direction = "back"
		if dir_vec[1] > 0:
			direction = "right"
	if v == Vector2(0, 0):
		direction = "not"

	v = move_and_slide(v)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Enemy"):
			player_hit(collider.collision_damage)

	if health <= 0:
		dying = true
		death_seconds = 1


func _input(event):  #turn to mouse
	if event is InputEventMouseMotion and not dying:
		var vec = event.position / get_viewport_rect().size - Vector2(0.5, 0.5)
		rotation = vec.angle() - PI / 2


func _on_XPCollector_area_entered(area):
	$XPSound.play()
	if area.is_in_group("collectable"):
		area.caught = true


func player_hit(damage):
	if invincible_seconds == 0.0:
		health -= damage
		invincible_seconds = 1.5
		# print(health)


func on_level_up():
	var lvlup = scene_lvlup.instance()
	UI.add_child(lvlup)


func on_level_up_finished():
	xp -= xp_needed
	level += 1
	xp_needed = 5 * level


func get_upgrade_level(name):
	var node = $Upgrades.get_node_or_null(name)
	return 0 if not node else node.level


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
	var gameover = scene_gameover.instance()
	gameover.score = score
	gameover.time = round(timer)
	UI.add_child(gameover)
