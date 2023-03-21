extends Node2D

func _ready():
	pass

func _process(_delta):
	pass

var debug_lines={}
func draw_debug_line(tag,a,b,color=Color.blanchedalmond,thickness=5):
	if(OS.is_debug_build()):
		if(!debug_lines.has(tag)):
			debug_lines[tag]=[]
		var line =Line2D.new()
		line.points=[a,b]
		line.default_color=color
		line.width=thickness
		get_node("/root").add_child(line)
		debug_lines[tag].append(line)

func clear_debug_lines(tag):
	if(OS.is_debug_build()):
		if(debug_lines.has(tag)):
			for line in debug_lines[tag]:
				line.queue_free()
			debug_lines[tag]=[]
