extends Node

# https://www.youtube.com/watch?v=I_Kzb-d-SvM&t=1240s

var file_path = "user://teclas.ini"
var config_file
var keybinds = {}

var node_botao_mudando
var waiting_input = false
var selecionar = true

func chamar_controles():
	atualizar_texto_botao()

func iniciar():
	load_file()
	set_game_binds()

func definir():
	set_game_binds()
	write_config()

func redefinir():
	salvar_arquivo_inicial()
	load_file()
	set_game_binds()
	atualizar_texto_botao()

func load_file():
	config_file = ConfigFile.new()
	var erro = config_file.load(file_path)
	
	if erro == OK:
		for key in config_file.get_section_keys("keybinds"):
			var key_value = config_file.get_value("keybinds", key)
			keybinds[key] = key_value
	elif erro == 7:
		salvar_arquivo_inicial()

func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		var new_key = InputEventKey.new()
		new_key.set_scancode(value)
		InputMap.action_add_event(key, new_key)

func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		config_file.set_value("keybinds", key, key_value)
		
	config_file.save(file_path)

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
		set_game_binds()
		
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

func salvar_arquivo_inicial():
	var configuracoes_iniciais = "[keybinds]\n\nui_up=87\nui_down=83\nui_right=68\nui_left=65\nui_accept=32\ninteragir=69\nui_cancel=81\ngirar=16777237"
	var file : File = File.new()
	if file.open(file_path, File.WRITE) == OK:
		file.store_line(configuracoes_iniciais)
		file.close()

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
