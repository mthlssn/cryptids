extends Control

func chamar_jogar():
	DataPlayer.load_saves()
	var saves = Global.get_saves()
	
	for key in saves.keys():
		if saves[key] == "nd":
			get_nodes_botoes(key).text = "novo jogo"
		else:
			get_nodes_botoes(key).text = saves[key]

func selecionar_um_save(save):
	var saves = Global.get_saves()
	
	Global.set_save(save)
	
	if saves[save] == "nd":
		Eventos.chamar_evento()
		return null
	else:
		return saves[save]

func continuar_save():
	DataPlayer.carregar()
	Eventos.chamar_evento()

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
