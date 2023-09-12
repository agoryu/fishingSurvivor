extends PowerUp


func action():
	player.fishing_mode.cursor_speed -= resource.value
	super.action()
