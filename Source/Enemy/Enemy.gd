extends KinematicBody2D
export var collision_damage = 1
export var speed = 100
export var health = 3
export var maxhealth = 3 #this is just for score
export var type = "blue"
export var variations = ["one", "two"]
var damage_anim_seconds = 0
var variation = "one"
var direction = "r"
var action = "walk"

var scene_xp = preload("res://Source/XP/XP.tscn")


func _ready():
	variations.shuffle()
	variation = variations[0]


func _process(delta):
	damage_anim_seconds = max(damage_anim_seconds - delta, 0)
	if damage_anim_seconds > 0:
		$AnimatedSprite.play("damage")
	#else:
	#$AnimatedSprite.play("default")
	var animation = variation + "_" + type + "_" + direction + "_" + action
	$AnimatedSprite.play(animation)


func _physics_process(_delta):
	var v = (Player.position - position).normalized() * speed
	#rotation = v.angle() - PI / 2
	if v[0] < 0:
		direction = "l"
	if v[0] > 0:
		direction = "r"

	v = move_and_slide(v)

	#check if touching player for punch animation
	action = "walk"
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider == Player:
			action = "punch"


func damage(amount):
	#damage_anim_seconds = 0.5
	health -= amount
	if health <= 0:
		die()


func die():
	Player.score += maxhealth * 10
	var xp = scene_xp.instance()
	xp.position = position
	get_tree().get_root().call_deferred("add_child", xp)
	queue_free()
