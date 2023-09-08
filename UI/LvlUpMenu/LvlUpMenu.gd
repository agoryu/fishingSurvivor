extends Panel

@onready var container = $VBoxContainer/HBoxContainer
var buttons : Array

var actions = {
	"res://UI/PowerUp/Gold.tscn": 100,
	"res://UI/PowerUp/ReduceThrowingLineTime.tscn": 5
}

var player: Player = preload("res://Character/Player/Player.tscn").instantiate()

func _ready():
	_on_visibility_changed()

func _on_visibility_changed():
	if not visible or container == null:
		return
	for button in buttons:
		button.queue_free()
		
	for i in range(3):
		var action_index = randi() % actions.size()
		var action = actions.keys()[action_index]
		var button = load(action).instantiate()
		button.close_powerup.connect(select_powerup)
		button.player = player
		container.add_child(button)
		if i == 0:
			button.grab_focus()
			
func select_powerup(button_selected: PowerUp):
	actions[button_selected.scene_file_path] -= 1
	var action = actions[button_selected.scene_file_path]
	if action <= 0:
		actions.erase(action)
