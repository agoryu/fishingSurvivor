extends Control

@onready var timer = $Timer
@onready var label = $Label

func congratulation():
	label.text = "Congratulation"
	start_label()
	
func failed():
	label.text = "Oups"
	start_label()
	
func start_label():
	timer.start()
	visible = true
	
func _on_timer_timeout():
	label.text = ""
	visible = false
	
func lvl_up():
	label.text = "New level"
	start_label()
