extends PowerUp

func action():
	player.wait_timer.wait_time -= resource.value
	super.action()
