extends Panel

@onready var container = $VBoxContainer/HBoxContainer

@export var powerup_resources: Array
var actions: Array

var player: Player = preload("res://Character/Player/Player.tscn").instantiate()

func _ready():
	_on_visibility_changed()
	for resource in powerup_resources:
		for i in range(resource.probability):
			actions.append(resource)

func _on_visibility_changed():
	if container == null:
		return
	
	get_tree().paused = visible
	if not visible:
		for button in container.get_children():
			button.queue_free()
	else:
		for i in range(3):
			var action_index = randi() % actions.size()
			var actionResource = actions[action_index]
			var button = actionResource.button_scene.instantiate()
			button.close_powerup.connect(select_powerup)
			button.player = player
			button.resource = actionResource
			container.add_child(button)
			if i == 0:
				button.grab_focus()
			
func select_powerup(button_selected: PowerUp):
	button_selected.resource.limit -= 1
	if button_selected.resource.limit <= 0:
		for i in range(button_selected.resource.probability):
			actions.erase(button_selected.resource)
	visible = false
