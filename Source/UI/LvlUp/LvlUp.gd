extends HBoxContainer

var available


func _ready():
	# get random upgrades
	available = Player.get_available_upgrades()
	available.shuffle()
	# print(available)
	for i in range(0, 3):
		var button = get_child(i)
		if available.size() <= i:
			button.queue_free()
			break
		button.get_node("Title").text = available[i].display_name
		button.get_node("Description").text = available[i].description
	get_tree().paused = true


func pressed(choice):
	available[choice - 1].on_upgrade()
	get_tree().paused = false
	queue_free()


func _on_Button1_pressed():
	pressed(1)


func _on_Button2_pressed():
	pressed(2)


func _on_Button3_pressed():
	pressed(3)
