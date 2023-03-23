extends Area2D
var time_alive=0
var base_radius=0
var base_scale=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	base_radius=$CollisionShape2D.shape.radius
	base_scale=$AnimatedSprite.scale
	pass # Replace with function body.


func _physics_process(delta):
	if(!get_tree().paused):
		time_alive+=delta
	if(time_alive>1):
		queue_free()
		return

	var scalefactor=pow(Player.get_upgrade_level("aoe")+3 ,time_alive)
	$CollisionShape2D.shape.radius=base_radius*scalefactor
	$AnimatedSprite.scale=base_scale*scalefactor




func _on_Area2D_body_entered(body):
	body.damage(Player.get_upgrade_level("damage")+1)
	pass # Replace with function body.
