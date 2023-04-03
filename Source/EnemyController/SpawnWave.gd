extends Node2D

export(float) var start_time = 0.0
export(float) var end_time = 0.0
export(float) var linear_factor = 1.0
export(float) var exponent = 1.0
export(float) var base = 0.0
export(float) var base_count = 1.0
export(NodePath) var entity
export(bool) var delete_when_full = true
var packed_scene


func _ready():
	if get_node_or_null(entity) == null:
		# print("Warning: Spawnwave without assigned entity, assigning child")
		entity = get_children()[0].get_path()
	var node = get_node(entity)
	var scene = PackedScene.new()
	scene.pack(node)
	packed_scene = scene
	node.queue_free()
