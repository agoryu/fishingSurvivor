extends PowerUp

func action():
	if player.throw_line_time > 0.5:
		player.throw_line_time -=0.2
	super.action()
