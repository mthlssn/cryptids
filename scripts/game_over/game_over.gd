extends Control

func _ready():
	Global.set_mover(false)
	Global.set_pausar(false)
	
	if Global.get_resultado_combate():
		chamar_game_over("game_over1")
	else:
		chamar_game_over("game_over2")

func chamar_game_over(tipo_game_over):
	match tipo_game_over:
		"game_over1":
			$game_over1.show()
			$game_over1/sair.grab_focus()
			
			$game_over2.hide()
		"game_over2":
			$game_over1.hide()
			
			$game_over2.show()
			$game_over2/nao.grab_focus()

func _on_sair_pressed():
	Transition.fade(self, "res://scenes/start_scene/start_scene.tscn", 1, "fade", false)

func _on_nao_pressed():
	DataPlayer.carregar()
	Global.set_novo_jogo(false)
	Transition.fade(self, "res://scenes/demo/demo.tscn", 1, "fade", true)

func _on_sim_pressed():
	Transition.fade(self, "res://scenes/start_scene/start_scene.tscn", 1, "fade", false)
