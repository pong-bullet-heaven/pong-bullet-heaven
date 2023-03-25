extends KinematicBody2D

export var health = 20
export var invincible_seconds = 0
var base_speed = 500
var xp = 0
var xp_needed = 1
var level = 0


func _ready():
	pass


func _process(_delta):
	if xp >= xp_needed:
		on_level_up()


func _physics_process(delta):
	invincible_seconds = max(invincible_seconds - delta, 0)
	var speed = base_speed + 100 * get_upgrade_level("speed")
	if Input.is_action_pressed("action"):
		speed = 0

	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if v.length() > 0:
		v = v.normalized() * speed

	if invincible_seconds > 0:
		$AnimatedSprite.play("damage")
	elif v.length() > 0:
		$AnimatedSprite.play("walking")
	else:
		$AnimatedSprite.stop()
	v = move_and_slide(v)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider.is_in_group("Enemy"):
			player_hit(collider)

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


func player_hit(enemy):
	if invincible_seconds == 0:
		health -= enemy.collision_damage
		invincible_seconds = 0.5
		# print(health)


func on_level_up():
	var scene_lvlup = load("res://Source/UI/Levelup/LevelUp.tscn")
	xp -= xp_needed
	level += 1
	xp_needed = 5 * level
	# print("lvl up")
	UI.add_child(scene_lvlup.instance())


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
