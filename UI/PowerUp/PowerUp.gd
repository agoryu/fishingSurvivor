extends Button

class_name PowerUp

signal close_powerup

@export var probability: int = 1
@export var nb_time: int = 2

var player: Player

func action():
	close_powerup.emit(self)

