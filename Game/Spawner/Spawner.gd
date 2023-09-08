extends Path2D

@export var sushi_scene = preload("res://Character/Fish/FirstFish.tscn")

@onready var spawn_location = $PathFollow2D

func _on_enemy_spawner_timer_timeout():
	var sushi = sushi_scene.instantiate()
	
	spawn_location.progress_ratio = randf()
	var direction = spawn_location.rotation + PI / 2
	
	sushi.position = spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	sushi.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	sushi.linear_velocity = velocity.rotated(direction)
	
	get_tree().root.add_child(sushi)
