extends Area2D
export var value=1
var speed=1000
var caught=false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	pass
func _physics_process(delta):
	if(caught):
		var v=(Player.position-position).normalized() * speed
		position+=v*delta
		speed+=delta*100

func _on_Node2D_body_entered(body):
	if(body == Player):
		Player.xp+=value
		queue_free()
