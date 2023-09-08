extends RigidBody2D

class_name Fish

@export var strength = 4
@export var limit = 3
@export var xp_value = 1

@onready var switch_direction_timer = $SwitchDirectionTimer

var old_velocity = Vector2.ONE

func _physics_process(delta):
	if abs(linear_velocity.x) < 100 and abs(linear_velocity.y) < 100:
		linear_velocity *= 1.2

func _on_visible_on_screen_notifier_2d_screen_exited():
	switch_direction_timer.start()

func _on_switch_direction_timer_timeout():
	switch_direction()
	
func switch_direction():
	var direction = rotation + PI / 2
	rotation = direction
	linear_velocity = linear_velocity.rotated(direction)

func capture():
	old_velocity = linear_velocity
	linear_velocity = Vector2.ZERO
	
func escape():
	linear_velocity = old_velocity
