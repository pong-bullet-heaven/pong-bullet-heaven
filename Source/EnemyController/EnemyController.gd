extends Node2D
export(float) var timer = 1.0
export(int) var maximum = 300

# radius outside of vision of player
var radius
var time_elapsed


func _ready():
	_setup()


func clear():
	_setup()


func _setup():
	radius = 800
	time_elapsed = 0


func _process(delta):
	var enemy_overflow = get_enemy_count() - maximum
	if enemy_overflow > 0:
		delete(enemy_overflow)

	timer -= delta
	time_elapsed += delta
	if timer < 0:
		timer = 1
		for wave in get_children():
			if wave.start_time <= time_elapsed and wave.end_time > time_elapsed:
				spawn_wave(wave)


func spawn_wave(wave):
	var exponential_count = wave.base_count * pow(wave.base, time_elapsed)
	var polynomial_count = wave.base_count * pow(time_elapsed, wave.exponent)
	var count = (exponential_count + polynomial_count) * wave.linear_factor
	count = floor(count)

	#delete enemies if not enough space
	var enemy_space = maximum - get_enemy_count()
	if enemy_space < count:
		count = delete(count - enemy_space) + enemy_space

	for j in count:
		var scene = wave.packed_scene
		spawn_enemy(wave, scene)


func spawn_enemy(wave, scene):
	var angle = randf() * 2 * PI
	var pos = Player.position + Vector2(0, radius).rotated(angle)
	var enemy = scene.instance()
	enemy.position = pos
	wave.add_child(enemy)


func get_enemy_count():
	var count = 0
	for wave in get_children():
		count += wave.get_child_count()
	return count


func delete(count):  #delete enemies, return amount of deleted enemies
	var deleted = 0
	for wave in get_children():
		if wave.delete_when_full:
			for enemy in wave.get_children():
				if enemy.position.distance_to(Player.position) > radius:
					enemy.queue_free()
					count -= 1
					deleted += 1
					if count <= 0:
						return deleted
	return deleted
