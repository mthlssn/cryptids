extends Node

# ------------- vars ----------------
var _interacao_arvore : bool

var _cena_atual : int

var _direcao_players : Array

var _girassol : bool

var _interacoes_maria : int

var _interagidos : Array

var _mover : bool

var _node_demo : Node

var _nodes_apagados : Array

var _nome_player : String # {nome_player}

var _novo_jogo : bool

var _onze_horas : bool

var _pausar : bool

var _players : Array

var _posicao_players : Array
# ------------- funcs ----------------

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	set_valores_iniciais()

func set_valores_iniciais():
	_interacao_arvore = false
	_cena_atual = 1
	_direcao_players = []
	_girassol = false
	_interacoes_maria = 0
	_interagidos = []
	_mover = false
	_node_demo = null
	_nodes_apagados = []
	_nome_player = "???"
	_novo_jogo = true
	_onze_horas = false
	_pausar = true
	_players = []
	_posicao_players = []

#------- interacao_arvore:
func set_interacao_arvore(interacao_arvore):
	_interacao_arvore = interacao_arvore

func get_interacao_arvore():
	return _interacao_arvore

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

#------- girassol:
func get_girassol():
	return _girassol

func set_girassol(girassol):
	_girassol = girassol

#------- interacoes_maria:
func get_interacoes_maria():
	return _interacoes_maria

func set_interacoes_maria(interacoes_maria):
	_interacoes_maria = interacoes_maria

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

#------- novo_jogo:
func get_novo_jogo():
	return _novo_jogo
	
func set_novo_jogo(novo_jogo):
	_novo_jogo = novo_jogo

#------- onze_horas:
func get_onze_horas():
	return _onze_horas

func set_onze_horas(onze_horas):
	_onze_horas = onze_horas

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
