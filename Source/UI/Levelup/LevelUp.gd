extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var available
# Called when the node enters the scene tree for the first time.
func _ready():
	#get random upgrades
	available=Player.get_available_upgrades()
	available.shuffle()
	print(available)
	for i in range(0,3):
		var button = get_child(i)
		if(available.size()<=i):
			button.queue_free()
			break
		button.get_node("Title").text=available[i].display_name
		button.get_node("Description").text=available[i].description


	get_tree().paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func pressed(choice):
	available[choice].on_upgrade()
	get_tree().paused = false
	queue_free()

func _on_Button_pressed():
	pressed(0)
	pass # Replace with function body.


func _on_Button2_pressed():
	pressed(1)
	pass # Replace with function body.


func _on_Button3_pressed():
	pressed(2)
	pass # Replace with function body.
