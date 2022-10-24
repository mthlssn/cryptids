extends Node

var save_path_1 : String = "user://save1.dat"
var save_path_2 : String = "user://save2.dat"
var save_path_3 : String = "user://save3.dat"

var configs_path : String = "user://configs.ini"
var config_file

var data_dictionary = {}

var _save : String

var _saves = {
	"save1" : "nd",
	"save2" : "nd", 
	"save3" : "nd"
}

var _keybinds = {
	"ui_up" : 87,
	"ui_down" : 83,
	"ui_right" : 68,
	"ui_left" : 65,
	"ui_accept" : 32,
	"interagir" : 69,
	"ui_cancel" : 81,
	"girar" : 16777237
}

var _tamanho_tela : Dictionary = {
	"tamanho_tela" : "720x432"
}

var _keybinds_iniciais = _keybinds.duplicate()

func _ready():
	load_configs("saves")
	load_configs("keybinds")
	load_configs("tamanho_tela")
	
	set_tela()
	set_game_binds()

# ================= data

func salvar():
	_saves[_save] = Global.get_nome_player()
	save_configs("saves")
	_save_data_dictionary()
	save_data(_save)

func carregar():
	load_data(_save)
	_load_data_dictionary()

func apagar():
	_saves[_save] = "nd"
	save_configs("saves")
	clear_data(_save)
	save_data(_save)

func save_data(save):
	var file : File = File.new()
	
	if file.open(_get_save_path(save), File.WRITE) == OK:
		file.store_var(data_dictionary)
		file.close()

func load_data(save):
	var file : File = File.new()
	
	if file.file_exists(_get_save_path(save)):
		if file.open(_get_save_path(save), File.READ) == OK:
			data_dictionary = file.get_var()
			file.close()

func clear_data(save):
	var data_dictionary_empty = {}
	var file : File = File.new()
	
	if file.open(_get_save_path(save), File.WRITE) == OK:
		file.store_var(data_dictionary_empty)
		file.close()

# ================= configs

func save_configs(selection):
	var config
	match selection:
		"saves":
			config = _saves
		"keybinds":
			config = _keybinds
		"tamanho_tela":
			config = _tamanho_tela
	
	for key in config.keys():
		var key_value = config[key]
		config_file.set_value(selection, key, key_value)
		
	config_file.save(configs_path)

func load_configs(selection):
	config_file = ConfigFile.new()
	var erro = config_file.load(configs_path)
	
	if erro == OK:
		for key in config_file.get_section_keys(selection):
			var key_value = config_file.get_value(selection, key)
			match selection:
				"saves":
					_saves[key] = key_value
				"keybinds":
					_keybinds[key] = key_value
				"tamanho_tela":
					_tamanho_tela[key] = key_value
	elif erro == 7:
		var file : File = File.new()
	
		if file.open(configs_path, File.WRITE) == OK:
			file.close()
		
		save_configs("saves")
		save_configs("keybinds")
		save_configs("tamanho_tela")


# ================= gets_and_sets

#------- keybinds:
func set_keybinds(keybinds):
	_keybinds = keybinds.duplicate()

func get_keybinds():
	return _keybinds.duplicate()

#------- keybinds_iniciais:
func get_keybinds_iniciais():
	return _keybinds_iniciais.duplicate()

#------- save:
func set_save(save):
	_save = save

func get_save():
	return _save

#------- saves:
func set_saves(saves):
	_saves = saves.duplicate()

func get_saves():
	return _saves.duplicate()

#------- tamanho_tela:
func set_tamanho_tela(tamanho_tela):
	_tamanho_tela = tamanho_tela.duplicate()

func get_tamanho_tela():
	return _tamanho_tela.duplicate()

# ================= funcs

func _get_save_path(save):
	match save:
		"save1":
			return save_path_1
		"save2":
			return save_path_2
		"save3":
			return save_path_3

func _save_data_dictionary():
	data_dictionary = {
		"cena_atual" : Global.get_cena_atual(),
		"direcao_player" : Global.get_direcao_players(),
		"interagidos" : Global.get_interagidos(),
		"mover" : Global.get_mover(),
		"nodes_apagados" : Global.get_nodes_apagados(),
		"nome_player" : Global.get_nome_player(),
		"players" : Global.get_players(),
		"posicao_players" : Global.get_posicao_players(), 
	}

func _load_data_dictionary():
	Global.set_cena_atual(data_dictionary["cena_atual"])
	Global.set_direcao_players(data_dictionary["direcao_player"])
	Global.set_interagidos(data_dictionary["interagidos"])
	Global.set_mover(data_dictionary["mover"])
	Global.set_nodes_apagados(data_dictionary["nodes_apagados"])
	Global.set_nome_player(data_dictionary["nome_player"])
	Global.set_players(data_dictionary["players"])
	Global.set_posicao_players(data_dictionary["posicao_players"])

func set_game_binds(): 
	for key in _keybinds.keys():
		var value = _keybinds[key]
		
		var actionlist = InputMap.get_action_list(key)
		if !actionlist.empty():
			InputMap.action_erase_event(key, actionlist[0])
		
		var new_key = InputEventKey.new()
		new_key.set_scancode(value)
		InputMap.action_add_event(key, new_key)

func set_tela():
	OS.window_fullscreen = false
	
	var tamanho = _tamanho_tela["tamanho_tela"]
	match tamanho:
		"tela_inteira":
			OS.window_fullscreen = true
		"960x576":
			OS.window_size = Vector2(960,576)
		"720x432":
			OS.window_size = Vector2(720,432)
	
	OS.center_window()
