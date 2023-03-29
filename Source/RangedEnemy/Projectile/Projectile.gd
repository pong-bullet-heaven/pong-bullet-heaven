extends Area2D

export var projectile_damage = 1
export(int) var speed: int = 300
var direction: Vector2 = Vector2.LEFT


func _ready():
	pass


func _physics_process(delta):
	translate(direction * speed * delta)


func clear():
	queue_free()


#func _on_Projectile_area_entered(area):
#	clear()


func _on_Projectile_body_entered(body):
	if body == Player:
		Player.player_hit(projectile_damage)
		# print(body.health)
		clear()


func _on_VisibilityNotifier2D_screen_exited():
	clear()
