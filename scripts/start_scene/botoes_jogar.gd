extends Control

func chamar_jogar():
	DataPlayer.load_configs("saves")
	var saves = DataPlayer.get_saves()
	
	for key in saves.keys():
		if saves[key] == "nd":
			get_nodes_botoes(key).text = "novo jogo"
		else:
			get_nodes_botoes(key).text = saves[key]

func selecionar_um_save(save):
	var saves = DataPlayer.get_saves()
	
	DataPlayer.set_save(save)
	
	if saves[save] == "nd":
		Global.set_novo_jogo(true)
		Transition.fade(self, "res://scenes/cutscene/cutscene.tscn", 1, "fade", true)
		return null
	else:
		return saves[save]

func continuar_save():
	DataPlayer.carregar()
	Global.set_novo_jogo(false)
	
	if Global.get_zerou():
		Global.set_resultado_combate(true)
		Transition.fade(self, "res://scenes/game_over/game_over.tscn", 1, "fade", false)
	else:
		Transition.fade(self, "res://scenes/demo/demo.tscn", 1, "fade", false)

func apagar_save():
	DataPlayer.apagar()

func get_nodes_botoes(key):
	match key:
		"save1":
			return get_node("save1_botao")
		"save2":
			return get_node("save2_botao")
		"save3":
			return get_node("save3_botao")
