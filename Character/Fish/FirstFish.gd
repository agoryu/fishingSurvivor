extends RigidBody2D

class_name Fish

@export var strength = 4
@export var limit = 3
@export var xp_value = 1

@onready var sprite: Sprite2D = $Sprite2D

var old_velocity = Vector2.ONE

func _physics_process(delta):
	if abs(linear_velocity.x) < 100 and abs(linear_velocity.y) < 100:
		linear_velocity *= 1.2

func capture():
	old_velocity = linear_velocity
	linear_velocity = Vector2.ZERO
	
func escape():
	linear_velocity = old_velocity
	
func switch_x():
	linear_velocity.x *= -1
	sprite.flip_v = not sprite.flip_v
	
func switch_y():
	linear_velocity.y *= -1
	sprite.flip_h = not sprite.flip_h
