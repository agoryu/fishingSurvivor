extends PowerUp

func action():
	player.throw_line_time -=0.2
	super.action()
