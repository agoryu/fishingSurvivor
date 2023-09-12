extends CanvasLayer

signal fishing_success
signal fishing_failed

@onready var cursor = $Cursor
@onready var collider = $Cursor/CollisionShape2D
@onready var timer = $Timer
@onready var result_fiching = $ResultFishing
@onready var zone1 = $Zone1
@onready var zone2 = $Zone2

var player: Player

var is_expansion = false
var is_in_zone1 = false
var is_in_zone2 = false
var is_paused = false
var boost_fishing = 0
var cursor_speed = 0.03

func _process(delta):
	if not visible:
		return
	if not collider.disabled and timer.is_stopped():
		fishing()
		finish_fishing()
		reset()
	elif not is_paused:
		if cursor.scale.x < 0 and not is_expansion: 
			is_expansion = true
		elif cursor.scale.x > 1 and is_expansion:
			is_expansion = false
		cursor.scale += Vector2(cursor_speed, cursor_speed) * (1 if is_expansion else -1)
		
func _input(event):
	if visible and event.is_action_released("ui_accept"):
		collider.disabled = false
		timer.start()
		is_paused = true

func reset():
	is_in_zone1 = false
	is_in_zone2 = false
	cursor.scale = Vector2.ONE
	collider.disabled = true
	is_paused = false

func _on_zone_1_area_entered(area):
	is_in_zone1 = true

func _on_zone_2_area_entered(area):
	is_in_zone2 = true

func finish_fishing():
	if player.fish_fishing.strength <= 0 or player.fish_fishing.limit <= 0:
		if player.fish_fishing.strength <= 0:
			emit_signal("fishing_success")
		elif player.fish_fishing.limit <= 0:
			emit_signal("fishing_failed")
		
func fishing():
	var fish = player.fish_fishing
	if is_in_zone1:
		fish.strength -= 2 + boost_fishing
		result_fiching.perfect()
	elif is_in_zone2:
		fish.strength -= 1 + boost_fishing
		result_fiching.great()
	else:
		result_fiching.failed()
	fish.limit -= 1

func _on_visibility_changed():
	if visible:
		player.fish_fishing.capture()
		
func boost_strength_fishing(value: int):
	boost_fishing += value
