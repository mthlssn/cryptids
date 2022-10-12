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
		"posicao_players" : Global.get_posicao_players(), 
		"direcao_player" : Global.get_direcao_players(),
		"cena_atual" : Global.get_cena_atual(),
		"players" : Global.get_players(),
		"interagidos" : Global.get_interagidos(),
		"nodes_apagados" : Global.get_nodes_apagados()
	}

func load_data_dictionary():
	Global.set_posicao_players(data_dictionary["posicao_players"])
	Global.set_direcao_players(data_dictionary["direcao_player"])
	Global.set_cena_atual(data_dictionary["cena_atual"])
	Global.set_players(data_dictionary["players"])
	Global.set_interagidos(data_dictionary["interagidos"])
	Global.set_nodes_apagados(data_dictionary["nodes_apagados"])

func _input(event):
	if event.is_action_pressed("salvar"):
		DataPlayer.save_data(1)
