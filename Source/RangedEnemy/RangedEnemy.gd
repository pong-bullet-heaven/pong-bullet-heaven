extends KinematicBody2D

export var collision_damage = 1
export var speed = 50
export var health = 3
export var backwardsspeed = -70

export var type = "blue"
export var variations = ["one", "two"]
var variation = "one"
var direction = "r"
var action = "walk"

var damage_anim_seconds = 0
var attacktimercount = 1
var timero = 0  # timer for moving back in a sprint
var move_back = false

var scene_projectile = preload("res://Source/RangedEnemy/Projectile/Projectile.tscn")
var scene_xp = preload("res://Source/XP/XP.tscn")


func _ready():
	pass


func _process(delta):  # no damage animation yet available
	damage_anim_seconds = max(damage_anim_seconds - delta, 0)


#	if(damage_anim_seconds > 0):
#		$AnimatedSprite.play("damage")
#	else:
#		$AnimatedSprite.play("default")


func move_forward(_delta):
	if timero <= 0:
		var v = (Player.position - position).normalized() * speed
		if v[0] < 0:
			direction = "l"
		if v[0] > 0:
			direction = "r"
		v = move_and_slide(v)
	else:
		move_backward(_delta)


func move_backward(_delta):
	if timero > 0:  # timer that counts down the backwards sprint
		timero -= _delta
		var c = (Player.position - position).normalized() * backwardsspeed
		if c[0] < 0:
			direction = "l"
		if c[0] > 0:
			direction = "r"
		c = move_and_slide(c)
	else:
		timero = 0.3


func _physics_process(_delta):
	if move_back == false:
		move_forward(_delta)
		attack_timer(_delta)
	elif move_back == true:
		move_backward(_delta)


func attack_timer(_delta):
	attacktimercount = attacktimercount - _delta
	if attacktimercount <= 0:
		shoot()
		attacktimercount = 8  # this is the attack speed


func shoot():  # shoot the projectile
	var projectile = scene_projectile.instance()
	get_tree().get_root().add_child(projectile)
	projectile.global_position = global_position
	var dir = (Player.global_position - global_position).normalized()
	projectile.global_rotation = dir.angle() + PI / 2.0
	projectile.direction = dir


func damage(amount):
	damage_anim_seconds = 0.5
	health -= amount
	if health <= 0:
		die()


func die():
	var xp = scene_xp.instance()
	xp.position = position
	get_tree().get_root().call_deferred("add_child", xp)
	queue_free()


func _on_Range_body_entered(body):
	if body.is_in_group("Player"):
		move_back = true


func _on_Range_body_exited(_body):
	move_back = false
