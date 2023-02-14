extends Node2D
export var timer=1
var radius
var time_elapsed=0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	radius=get_viewport_rect().end.length()+50
	
	
	timer-=delta
	time_elapsed+=delta
	if(timer<0):
		timer=1
		for wave in get_children():
			if(wave.start_time<=time_elapsed and wave.end_time>time_elapsed):
				spawn_wave(wave)
			
func spawn_wave(wave):
	var exponential_count = wave.base_count * pow( wave.base, time_elapsed )
	var polynomial_count  = wave.base_count * pow( time_elapsed,wave.exponent )
	var count =  (exponential_count+polynomial_count) * wave.linear_factor
	count=floor(count)
	print(count)
	for j in count:
		spawn_enemy(wave,wave.scene_path)
	pass
	
func spawn_enemy(wave,scene):
	var angle = randf()*2*PI
	var pos =Player.position+Vector2(0,radius).rotated(angle)
	var enemy=scene.instance()
	enemy.position=pos
	wave.add_child(enemy)
	pass
