extends CanvasLayer

var node_pause

func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("esc") && Global.get_pausar():
		pause()
		
func pause():
	node_pause = Global.get_node_demo()
	if node_pause:
		if node_pause.get_tree().paused == false:
			node_pause.get_tree().paused = true
			show()
			$botoes/continuar_botao.grab_focus()
		else:
			node_pause.get_tree().paused = false
			hide()

func _on_continuar_botao_pressed():
	node_pause.get_tree().paused = false
	hide()

func _on_configuracao_botao_pressed():
	pass # Replace with function body.

func _on_tela_inicial_botao_pressed():
	DataPlayer.save_data_dictionary()
	DataPlayer.save_data(1)
	pause()
	Transition.fade(node_pause, "res://scenes/start_scene/start_scene.tscn", 1, "fade_2")
