extends Area2D

export var value = 1
var speed = 1000
var caught = false
var combine_values = 0
var combineable_xp = []
var merging = false


func _ready():
	_set_graphic()


func clear():
	queue_free()


func _physics_process(delta):
	if caught:
		var v = speed * (Player.position - position).normalized()
		position += v * delta
		speed += 100 * delta


func _on_Node2D_body_entered(body):
	if body == Player:
		Player.xp += value
		queue_free()


func _on_CombineArea_area_entered(area):
	var added_xp = area.get_parent()
	if !merging:
		combine_values += added_xp.value
		combineable_xp.append(added_xp)
		if len(combineable_xp) > 3:
			var average_position = position
			for xp in combineable_xp:
				average_position += xp.position
				xp.merging = true
				value += xp.value
				xp.queue_free()
			average_position = average_position / (len(combineable_xp) + 1)
			position = average_position
			combineable_xp = []
			combine_values = 0
			_set_graphic()


func _on_CombineArea_area_exited(area):
	var removed_xp = area.get_parent()
	combine_values -= removed_xp.value
	combineable_xp.erase(removed_xp)


func _set_graphic():
	if value > 20:
		$AnimatedSprite.play("purple")
		return
	if value > 2:
		$AnimatedSprite.play("blue")
		return
	$AnimatedSprite.play("green")
