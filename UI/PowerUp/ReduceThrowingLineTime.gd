extends PowerUp

func action():
	player.throw_line_time -= resource.value
	super.action()
