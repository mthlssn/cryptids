extends Node

# ------------- vars ----------------

var _posicao_players 
var _direcao_players
var _cena_atual
var _node_demo
var _players
var _interagidos
var _mover
var _nodes_apagados

# ------------- funcs ----------------

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func set_valores_iniciais():
	_posicao_players = []
	_direcao_players = []
	_cena_atual = 1
	_node_demo = null
	_players = []
	_interagidos = []
	_mover = false
	_nodes_apagados = []
	
func set_pausar(pausar):
	_pausar = pausar
	
func get_pausar():
	return _pausar	
		
func get_nome_player():
	return _nome_player
	
func set_nome_player(nome_player):
	_nome_player = nome_player

func get_nodes_apagados():
	return _nodes_apagados

func set_nodes_apagados(nodes_apagados):
	_nodes_apagados = nodes_apagados

func get_mover():
	return _mover

func set_mover(mover):
	_mover = mover

func get_interagidos():
	return _interagidos

func set_interagidos(interagidos):
	_interagidos = interagidos

func get_direcao_players():
	return _direcao_players

func set_direcao_players(direcao_players):
	_direcao_players = direcao_players

func set_players(players):
	_players = players

func get_players():
	return _players

func set_node_demo(node):
	_node_demo = node

func get_node_demo():
	return _node_demo

func set_cena_atual(cena):
	_cena_atual = cena

func get_cena_atual():
	return _cena_atual

func set_posicao_players(posicao_players):
	_posicao_players = posicao_players

func get_posicao_players():
	return _posicao_players
