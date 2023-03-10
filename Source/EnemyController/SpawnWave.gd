extends Node2D
export(float) var start_time = 0
export(float) var end_time = 0
export(float) var linear_factor = 1
export(float) var exponent = 1
export(float) var base = 0
export(float) var base_count = 1
export(NodePath) var entity
export(bool) var delete_when_full = true
var packed_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	if(get_node(entity) == null):
		print("Warning: Spawnwave without assigned entity, assigning child")
		entity = get_children()[0].get_path()
	var scene = PackedScene.new()
	scene.pack(get_node(entity))
	packed_scene=scene
	get_node(entity).queue_free()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
