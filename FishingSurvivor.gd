extends Node2D

@onready var fishing_mode = $FishingMode
@onready var background = $Background
@onready var player: Player = $Player
@onready var ui = $UI

func _ready():
	fishing_mode.player = player

func _on_player_fishing():
	fishing_mode.visible = true

func fishing_finish():
	fishing_mode.visible = false
	player.wait()

func _on_fishing_mode_fishing_failed():
	fishing_finish()
	ui.failed()
	player.fish_fishing.escape()
	player.fish_fishing = null

func _on_fishing_mode_fishing_success():
	if not ui.add_xp(player.fish_fishing.xp_value):
		ui.congratulation()
	player.fish_fishing.queue_free()
	fishing_finish()
