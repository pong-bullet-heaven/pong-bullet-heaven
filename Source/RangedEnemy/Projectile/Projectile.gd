extends Area2D

export var projectile_damage = 1
export(int) var speed: int = 300
var direction: Vector2 = Vector2.LEFT

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	translate(direction*speed*delta)
	pass
func destroy():
	queue_free()



#func _on_Projectile_area_entered(area):
#	destroy()


func _on_Projectile_body_entered(Player):
	Player.health -= projectile_damage
	print(Player.health)
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
