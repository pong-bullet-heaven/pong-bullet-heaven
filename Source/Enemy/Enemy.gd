extends KinematicBody2D

export var collision_damage = 1
export var speed = 100
export var health = 3
var damage_anim_seconds = 0


func _ready():
	pass


func _process(delta):
	damage_anim_seconds = max(damage_anim_seconds - delta, 0)
	if damage_anim_seconds > 0:
		$AnimatedSprite.play("damage")
	else:
		$AnimatedSprite.play("default")


func _physics_process(_delta):
	var v = (Player.position - position).normalized() * speed
	rotation = v.angle() - PI / 2
	v = move_and_slide(v)


func damage(amount):
	damage_anim_seconds = 0.5
	health -= amount
	if health <= 0:
		die()


func die():
	var scene_xp = load("res://Source/XP/XP.tscn")
	var instance = scene_xp.instance()
	instance.position = position
	get_node("/root").call_deferred("add_child", instance)
	queue_free()
