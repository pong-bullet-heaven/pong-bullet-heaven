extends KinematicBody2D



export var health = 20
export var speed = 1000
export var invincibleSeconds=0
var xp=0
var xp_needed=1
var level=0
	
# Called when the node enters the scene tree for the first time.
func _ready():
	$XPCollector/CollisionShape2D.shape.radius=300 #change collection radius
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(xp>=xp_needed):
		on_level_up()
	pass

func _physics_process(delta):
	invincibleSeconds=max(invincibleSeconds-delta,0)
	var v = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if v.length() > 0:
		v = v.normalized() * speed

	if(invincibleSeconds>0):
		$AnimatedSprite.play("damage")
	elif(v.length() > 0):
		$AnimatedSprite.play("walking")
	else:
		$AnimatedSprite.stop()
	move_and_slide(v)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		var collider=collision.get_collider()
		if(collider.is_in_group("Enemy")):
			playerHit(collider)
	
	if(health<=0):
		queue_free()

func _input(event):#turn to mouse	
	if event is InputEventMouseMotion:
		var vec=event.position/get_viewport_rect().size-Vector2(0.5,0.5)
		rotation=vec.angle()-PI/2

func _on_XPCollector_area_entered(area):
	if(area.is_in_group("collectable")):
		area.caught=true

func playerHit(enemy):
	if(invincibleSeconds==0):
		health -= enemy.collision_damage
		invincibleSeconds=0.5
		print(health)

func on_level_up():
	xp-=xp_needed
	level+=1
	xp_needed = level*5
	print("level up")
