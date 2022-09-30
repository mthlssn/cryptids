extends CanvasLayer

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("esc"):
		pause()
		
func pause():
	var node_pause = Global.get_node_demo_cena()
		
	if node_pause:
		if node_pause.get_tree().paused == false:
			node_pause.get_tree().paused = true
			show()
		else:
			node_pause.get_tree().paused = false
			hide()
