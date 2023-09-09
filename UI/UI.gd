extends CanvasLayer

@onready var message = $VBoxContainer/MessageComponent
@onready var progressbar = $VBoxContainer/ProgressBar
@onready var lvl_menu = $LvlUpMenu

func congratulation():
	message.congratulation()
	
func failed():
	message.failed()
	
func add_xp(value: int) -> bool:
	var next_lvl_value = progressbar.max_value - (progressbar.value + value)
	if next_lvl_value <= 0:
		progressbar.value = abs(next_lvl_value)
		lvl_up()
		return true
	else:
		progressbar.value += value
		return false

func lvl_up():
	message.lvl_up()
	lvl_menu.visible = true
	progressbar.max_value += 1
