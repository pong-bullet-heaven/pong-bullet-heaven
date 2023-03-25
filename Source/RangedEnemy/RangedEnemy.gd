extends KinematicBody2D

export var collision_damage = 1
export var speed = 50
export var health = 3
export var backwardsspeed = -70
export var Projectile = preload("res://Source/RangedEnemy/Projectile/Projectile.tscn")
var damage_anim_seconds = 0
var attacktimercount = 1
var timero = 0  # timer for moving back in a sprint
var move_back = false


func _ready():
	pass


func _process(delta):  # no damage animation yet available
	damage_anim_seconds = max(damage_anim_seconds - delta, 0)


#	if(damage_anim_seconds > 0):
#		$AnimatedSprite.play("damage")
#	else:
#		$AnimatedSprite.play("default")


func move_forward():
	if timero == 0:
		var v = (Player.position - position).normalized() * speed
		rotation = v.angle() - PI / 2
		v = move_and_slide(v)
	else:
		move_backward()


func move_backward():
	if timero != 0:  # timer that counts down the backwards sprint
		timero -= 1
		var c = (Player.position - position).normalized() * backwardsspeed
		rotation = c.angle() - PI / 2
		c = move_and_slide(c)
	else:
		timero = 50


func _physics_process(_delta):
	if move_back == false:
		move_forward()
		attack_timer()
	elif move_back == true:
		move_backward()


func attack_timer():
	attacktimercount = attacktimercount - 1
	if attacktimercount == 0:
		shoot()
		attacktimercount = 800  # this is the attack speed


func shoot():  # shoot the projectile
	var projectile = Projectile.instance()
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
	var scene = load("res://Source/XPDrops/XP.tscn")
	var instance = scene.instance()
	instance.position = position
	get_node("/root").call_deferred("add_child", instance)
	queue_free()


func _on_Range_body_entered(body):
	if body.is_in_group("Player"):
		move_back = true


func _on_Range_body_exited(_body):
	move_back = false
