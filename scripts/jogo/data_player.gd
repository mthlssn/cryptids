extends Node

var save_path_1 : String = "user://save1.dat"
var save_path_2 : String = "user://save2.dat"
var save_path_3 : String = "user://save3.dat"

var saves_path : String = "user://saves.ini"
var config_file

var data_dictionary = {}

func salvar():
	var temp = Global.get_saves()
	temp[Global.get_save()] = Global.get_nome_player()
	Global.set_saves(temp)
	
	save_saves()
	save_data_dictionary()
	save_data(Global.get_save())

func carregar():
	load_data(Global.get_save())
	load_data_dictionary()

func apagar():
	var temp = Global.get_saves()
	temp[Global.get_save()] = "nd"
	Global.set_saves(temp)
	
	save_saves()
	clear_data(Global.get_save())
	save_data(Global.get_save())

func save_data(save):
	var file : File = File.new()
	var erro = file.open(get_save_path(save), File.WRITE)
	
	if erro == OK:
		file.store_var(data_dictionary)
		file.close()

func load_data(save):
	var file : File = File.new()
	
	if file.file_exists(get_save_path(save)):
		var erro = file.open(get_save_path(save), File.READ)
		
		if erro == OK:
			data_dictionary = file.get_var()
			file.close()

func clear_data(save):
	var data_dictionary_empty = {}
	
	var file : File = File.new()
	var erro = file.open(get_save_path(save), File.WRITE)
	
	if erro == OK:
		file.store_var(data_dictionary_empty)
		file.close()

func save_saves():
	var saves = Global.get_saves()
	
	for key in saves.keys():
		var key_value = saves[key]
		config_file.set_value("saves", key, key_value)
		
	config_file.save(saves_path)

func load_saves():
	config_file = ConfigFile.new()
	var erro = config_file.load(saves_path)
	
	var saves = Global.get_saves()
	
	if erro == OK:
		for key in config_file.get_section_keys("saves"):
			var key_value = config_file.get_value("saves", key)
			saves[key] = key_value
		Global.set_saves(saves)
	elif erro == 7:
		var saves_vazios = "[saves]\n\nsave1=\"nd\"\nsave2=\"nd\"\nsave3=\"nd\""
		var file : File = File.new()
		if file.open(saves_path, File.WRITE) == OK:
			file.store_line(saves_vazios)
			file.close()

func get_save_path(save):
	match save:
		"save1":
			return save_path_1
		"save2":
			return save_path_2
		"save3":
			return save_path_3

func save_data_dictionary():
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

func load_data_dictionary():
	Global.set_cena_atual(data_dictionary["cena_atual"])
	Global.set_direcao_players(data_dictionary["direcao_player"])
	Global.set_interagidos(data_dictionary["interagidos"])
	Global.set_mover(data_dictionary["mover"])
	Global.set_nodes_apagados(data_dictionary["nodes_apagados"])
	Global.set_nome_player(data_dictionary["nome_player"])
	Global.set_players(data_dictionary["players"])
	Global.set_posicao_players(data_dictionary["posicao_players"])
