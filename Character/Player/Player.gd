extends CharacterBody2D

class_name Player

signal fishing

enum {NOT_FISHING, THROW_LINE, FISHING, WAIT}

@export var fishing_mode : Node

@export var default_color : Color
@export var throw_line_color : Color
@export var fishing_color : Color
@export var wait_color : Color
@export var drag := 5.0
@export var speed = 300.0

@export var throw_line_time = 2.5
@export var fishing_time = 1.5
@export var wait_time = 2.0

@onready var player_collision: CollisionShape2D = $Area2D/CollisionShape2D
@onready var fishing_timer = $FishingTimer
@onready var zone: Sprite2D = $Sprite2D
@onready var wait_timer: Timer = $WaitTimer

var fish_fishing : Fish
var state = NOT_FISHING
var gold = 0

func _ready():
	fishing_timer.wait_time = throw_line_time
	wait_timer.wait_time = wait_time
	zone.modulate = default_color

func _physics_process(delta):
	if state == NOT_FISHING or state == WAIT:
		var desired_velocity = get_gamepad_direction() * speed
		var steering = desired_velocity - velocity
		velocity += steering / drag
		velocity = velocity.limit_length(speed)
		move_and_slide()

func _input(event):
	if state == NOT_FISHING and event.is_action_pressed("ui_accept"):
		fishing_timer.start()
		zone.modulate = fishing_color
		state = THROW_LINE

func get_gamepad_direction():
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

func _on_area_2d_body_entered(body: Fish):
	fish_fishing = body
	fishing_timer.stop()
	emit_signal("fishing")

func _on_fishing_timer_timeout():
	if state == THROW_LINE:
		player_collision.disabled = false
		zone.modulate = throw_line_color
		state = FISHING
		fishing_timer.wait_time = fishing_time
		fishing_timer.start()
	elif state == FISHING:
		wait()

func _on_wait_timer_timeout():
	state = NOT_FISHING
	zone.modulate = default_color

func wait():
	state = WAIT
	player_collision.disabled = true
	zone.modulate = wait_color
	wait_timer.start()
	fishing_timer.wait_time = throw_line_time
