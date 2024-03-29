extends CanvasLayer

var available


func _ready():
	# get random upgrades
	available = Player.get_available_upgrades()
	available.shuffle()
	# print(available)
	var bbcode_center = "[center]%s[/center]"
	for i in range(0, 3):
		var button = $HBoxContainer.get_child(i)
		if available.size() <= i:
			button.disabled = true
			button.size_flags_horizontal = 2
			button.get_node("Title").bbcode_text = ""
			button.get_node("Description").bbcode_text = ""
			button.get_node("Icon").texture = null
		else:
			button.get_node("Title").bbcode_text = bbcode_center % available[i].display_name
			button.get_node("Description").bbcode_text = bbcode_center % available[i].description
			button.get_node("Icon").texture = available[i].image

	UI.ui_visible(false)
	UI.ui_occupied(true)
	get_tree().paused = true

	if available.size() == 0:
		close()


func close():
	get_tree().paused = false
	UI.ui_occupied(false)
	UI.ui_visible(true)
	Player.on_level_up_finished()
	queue_free()


func pressed(choice):
	available[choice - 1].on_upgrade()
	close()


func _on_Button1_pressed():
	pressed(1)


func _on_Button2_pressed():
	pressed(2)


func _on_Button3_pressed():
	pressed(3)
