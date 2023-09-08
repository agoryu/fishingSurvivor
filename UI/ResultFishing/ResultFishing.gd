extends Control

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func failed():
	label.text = "Failed"
	start_label()
	
func great():
	label.text = "Great"
	start_label()
	
func perfect():
	label.text = "Perfect"
	start_label()
	
func start_label():
	timer.start()
	visible = true

func _on_timer_timeout():
	label.text = ""
	visible = false
