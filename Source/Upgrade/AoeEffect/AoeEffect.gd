extends Area2D
var time_alive = 0
var base_radius = 15
var base_scale = Vector2(1, 1)


func _ready():
	#this causes weird interference, use hardcoded values for now
	#base_radius=$CollisionShape2D.shape.radius
	#base_scale=$AnimatedSprite.scale
	pass


func clear():
	queue_free()


func _physics_process(delta):
	if !get_tree().paused:
		time_alive += delta
	if time_alive > 1:
		queue_free()
		return

	var scalefactor = pow(Player.get_upgrade_level("aoe") + 3, time_alive)
	scalefactor = scalefactor * pow(2.0 / 3.0, Player.get_upgrade_level("multi_ball"))
	$CollisionShape2D.shape.radius = base_radius * scalefactor
	$AnimatedSprite.scale = base_scale * scalefactor


func _on_Area2D_body_entered(body):
	var damage = Player.get_upgrade_level("damage") + 1
	damage = damage * pow(2.0 / 3.0, Player.get_upgrade_level("multi_ball"))
	body.damage(damage)
