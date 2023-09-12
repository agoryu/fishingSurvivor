extends PowerUp

func action():
	player.fishing_mode.boost_strength_fishing(resource.value)
	super.action()
