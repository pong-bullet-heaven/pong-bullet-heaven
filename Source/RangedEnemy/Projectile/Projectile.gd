extends Area2D

export var projectile_damage = 1
export(int) var speed: int = 300
var direction: Vector2 = Vector2.LEFT


func _ready():
	pass


func _physics_process(delta):
	translate(direction * speed * delta)


func destroy():
	queue_free()


#func _on_Projectile_area_entered(area):
#	destroy()


func _on_Projectile_body_entered(body):
	if body == Player:
		body.health -= projectile_damage
		print(body.health)
		destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
