extends KinematicBody2D

export var collision_damage=1
export var speed =100
export var health = 3
var damageAnimSeconds=0
func _ready():
	pass

func _process(delta):
	damageAnimSeconds=max(damageAnimSeconds-delta,0)
	if(damageAnimSeconds>0):
		$AnimatedSprite.play("damage")
	else:
		$AnimatedSprite.play("default")
	pass

func _physics_process(delta):
	var v=(Player.position-position).normalized() * speed
	rotation=v.angle()-PI/2
	move_and_slide(v)
	pass
func damage(amount):
	damageAnimSeconds=0.5
	health-=amount
	if(health<=0):
		die()

func die():
	var scene = load("res://Source/XPDrops/XP.tscn")
	var instance = scene.instance()
	instance.position=position
	get_node("/root").add_child(instance)
	
	queue_free()
