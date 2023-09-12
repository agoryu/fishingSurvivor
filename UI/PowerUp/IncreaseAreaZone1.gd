extends PowerUp

func action():
	player.fishing_mode.zone1.scale += Vector2(resource.value, resource.value)
	super.action()
