extends PowerUp

func action():
	player.gold += resource.value
	super.action()
