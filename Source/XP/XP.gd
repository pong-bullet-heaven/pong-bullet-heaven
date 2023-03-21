extends Area2D


export var value = 1
var speed = 1000
var caught = false


func _process(_delta):
	pass


func _physics_process(delta):
	if(caught):
		var v = speed * (Player.position - position).normalized()
		position += v * delta
		speed += 100 * delta


func _on_Node2D_body_entered(body):
	if(body == Player):
		Player.xp += value
		queue_free()
