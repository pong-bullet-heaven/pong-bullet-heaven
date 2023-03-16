extends CanvasLayer
export var draw_debug=true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (Input.is_action_just_pressed("toggle_fullscreen")):
		toggle_fullscreen()

func toggle_fullscreen():
	if (OS.window_fullscreen):
		var screen = OS.get_screen_size()
		var base = Vector2(1024, 576)
		var div = screen / base
		OS.window_size = floor(min(div[0], div[1])) * base
		OS.window_fullscreen = false
	else:
		OS.window_fullscreen = true

var debug_lines={}
func draw_debug_line(tag,a,b,color=Color.blanchedalmond,thickness=5):
	if(draw_debug):
		if(!debug_lines.has(tag)):
			debug_lines[tag]=[]
		var line =Line2D.new()
		line.points=[a,b]
		line.default_color=color
		line.width=thickness
		get_node("/root").add_child(line)
		debug_lines[tag].append(line)

func clear_debug_lines(tag):
	if(draw_debug):
		if(debug_lines.has(tag)):
			for line in debug_lines[tag]:
				line.queue_free()
			debug_lines[tag]=[]
