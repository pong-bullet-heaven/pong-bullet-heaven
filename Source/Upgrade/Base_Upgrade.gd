extends Node
export var display_name: String
export var description: String
export var level: int
export var max_level: int
export var required_Upgrades: Dictionary
export var required_Level: int

func on_upgrade():
	if(level<max_level):
		level+=1
		print(display_name)
		print(level)
	pass
