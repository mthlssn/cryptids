extends Node

var save_path_1 : String = "user://save1.dat"
var save_path_2 : String = "user://save2.dat"
var save_path_3 : String = "user://save3.dat"

var save_path

var data_dictionary = {}

var data_dictionary_empty = {}

func _ready():
	#save_data(1, false)
	#load_data(1)
	pass

func save_data(save):
	get_save_path(save)
	
	var file : File = File.new()
	var erro = file.open(save_path, File.WRITE)
	
	if erro == OK:
		file.store_var(data_dictionary)
		file.close()

func load_data(save):
	get_save_path(save)
	
	var file : File = File.new()
	
	if file.file_exists(save_path):
		var erro = file.open(save_path, File.READ)
		
		if erro == OK:
			data_dictionary = file.get_var()
			file.close()

func clear_data(save):
	get_save_path(save)
	
	var file : File = File.new()
	var erro = file.open(save_path, File.WRITE)
	
	if erro == OK:
		file.store_var(data_dictionary_empty)
		file.close()

func get_save_path(save):
	match save:
		1:
			save_path = save_path_1
		2:
			save_path = save_path_2
		3:
			save_path = save_path_3

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

func _input(event):
	if event.is_action_pressed("salvar"):
		DataPlayer.save_data(1)
