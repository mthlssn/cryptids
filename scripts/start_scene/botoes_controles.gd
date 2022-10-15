extends Node

# https://www.youtube.com/watch?v=I_Kzb-d-SvM&t=1240s

var keybinds

var node_botao_mudando
var waiting_input = false
var selecionar = true

func chamar_controles():
	keybinds = DataPlayer.get_keybinds()
	atualizar_texto_botao()

func definir():
	DataPlayer.save_configs("keybinds")

func redefinir():
	DataPlayer.set_keybinds(DataPlayer.get_keybinds_iniciais())
	DataPlayer.set_game_binds()
	keybinds = DataPlayer.get_keybinds_iniciais()
	atualizar_texto_botao()

func _input(event):
	if waiting_input:
		if event is InputEventKey:
			var value = event.scancode
			waiting_input = false
			
			mudar_uma_tecla(value)
			
			$timer.start()
			selecionar = false

func selecionar_uma_tecla(tecla):
	if selecionar:
		for nodes in get_nodes_botoes():
			if tecla in nodes.name:
				node_botao_mudando = nodes
			else:
				nodes.focus_mode = 0
		$redefinir_teclas.focus_mode = 0
		$controles_voltar.focus_mode = 0
		
		node_botao_mudando.text = ""
		waiting_input = true

func mudar_uma_tecla(value):
	var key
	var mudar = true
	
	for keys in keybinds.keys():
		if value == keybinds[keys]:
			mudar = false
	
	if mudar:
		match node_botao_mudando.name:
			"botao_cima":
				key = "ui_up"
			"botao_baixo":
				key = "ui_down"
			"botao_direita":
				key = "ui_right"
			"botao_esquerda":
				key = "ui_left"
			"botao_selecionar":
				key = "ui_accept"
			"botao_interagir":
				key = "interagir"
			"botao_sair":
				key = "ui_cancel"
			"botao_girar":
				key = "girar"
			
		keybinds[key] = value
		
		DataPlayer.set_keybinds(keybinds)
		DataPlayer.set_game_binds()
		
	atualizar_texto_botao()

func atualizar_texto_botao():
	var value = []
	value.resize(8)
	
	var cont = 0
	for key in keybinds.keys():
		value[cont] = keybinds[key]
		cont += 1
	
	cont = 0
	for botao in get_nodes_botoes():
		botao.text = OS.get_scancode_string(value[cont])
		cont += 1

func _on_timer_timeout():
	for nodes in get_nodes_botoes():
		nodes.focus_mode = 2
		
	$redefinir_teclas.focus_mode = 2
	$controles_voltar.focus_mode = 2
	
	selecionar = true

func get_nodes_botoes():
	return [get_node("container_horizontal/container_vertical2/botao_cima"),
	get_node("container_horizontal/container_vertical2/botao_baixo"),
	get_node("container_horizontal/container_vertical2/botao_direita"),
	get_node("container_horizontal/container_vertical2/botao_esquerda"),
	get_node("container_horizontal/container_vertical3/botao_selecionar"),
	get_node("container_horizontal/container_vertical3/botao_interagir"),
	get_node("container_horizontal/container_vertical3/botao_sair"),
	get_node("container_horizontal/container_vertical3/botao_girar")]
