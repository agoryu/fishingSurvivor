extends Node2D

func _on_body_entered(body: Fish):
	body.switch_y()
