extends Button

class_name PowerUp

signal close_powerup

var player: Player
var resource: PowerUpResource

func action():
	close_powerup.emit(self)

