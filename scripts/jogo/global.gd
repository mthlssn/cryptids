extends Node

# ------------- vars ----------------

var _cena_atual : int

var _direcao_players : Array

var _interagidos : Array

var _mover : bool

var _node_demo : Node

var _nodes_apagados : Array

var _nome_player : String # {nome_player}

var _pausar : bool

var _players : Array

var _posicao_players : Array

var _save : String

var _saves : Dictionary

# ------------- funcs ----------------

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func set_valores_iniciais():
	_cena_atual = 1
	_direcao_players = []
	_interagidos = []
	_mover = false
	_node_demo = null
	_nodes_apagados = []
	_nome_player = "???"
	_pausar = true
	_players = []
	_posicao_players = []
	_save = ""
	_saves = {"save1" : "nd", "save2" : "nd", "save3" : "nd"}

#------- cena_atual:
func set_cena_atual(cena):
	_cena_atual = cena

func get_cena_atual():
	return _cena_atual

#------- direcao_players:
func get_direcao_players():
	return _direcao_players

func set_direcao_players(direcao_players):
	_direcao_players = direcao_players

#------- interagidos:
func get_interagidos():
	return _interagidos

func set_interagidos(interagidos):
	_interagidos = interagidos

#------- mover:
func get_mover():
	return _mover

func set_mover(mover):
	_mover = mover

#------- node_demo:
func set_node_demo(node_demo):
	_node_demo = node_demo

func get_node_demo():
	return _node_demo

#------- nodes_apagados:
func get_nodes_apagados():
	return _nodes_apagados

func set_nodes_apagados(nodes_apagados):
	_nodes_apagados = nodes_apagados

#------- nome_player:
func get_nome_player():
	return _nome_player
	
func set_nome_player(nome_player):
	_nome_player = nome_player

#------- pausar:
func set_pausar(pausar):
	_pausar = pausar
	
func get_pausar():
	return _pausar	

#------- players:
func set_players(players):
	_players = players

func get_players():
	return _players

#------- posicao_players:
func set_posicao_players(posicao_players):
	_posicao_players = posicao_players

func get_posicao_players():
	return _posicao_players

#------- save:
func set_save(save):
	_save = save

func get_save():
	return _save

#------- saves:
func set_saves(saves):
	_saves = saves

func get_saves():
	return _saves
