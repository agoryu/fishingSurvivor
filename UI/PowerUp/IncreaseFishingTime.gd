extends PowerUp

func action():
	player.fishing_time += resource.value
	super.action()
