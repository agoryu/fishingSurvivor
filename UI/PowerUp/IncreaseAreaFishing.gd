extends PowerUp

func action():
	player.scale += Vector2(resource.value, resource.value)
	super.action()
	
