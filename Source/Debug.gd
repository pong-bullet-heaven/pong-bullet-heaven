extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	update()

func _draw():
	var borders = get_borders()

	draw_line(Vector2(borders.left, borders.top), Vector2(borders.right, borders.bottom), Color(255, 255, 255), 10)
	draw_line(Vector2(borders.right, borders.top), Vector2(borders.left, borders.bottom), Color(255, 255, 255), 10)

	draw_rect(Rect2(Vector2(borders.left, borders.top), OS.window_size), Color(255, 255, 255), false, 10)

func get_borders():
	var window_size = OS.window_size
	var window_size_half_x = window_size[0] / 2
	var window_size_half_y = window_size[1] / 2
	var player_position_x = Player.position[0]
	var player_position_y = Player.position[1]
	return {
		"bottom": player_position_y + window_size_half_y,
		"left": player_position_x - window_size_half_x,
		"right": player_position_x + window_size_half_x,
		"top": player_position_y - window_size_half_y
	}
