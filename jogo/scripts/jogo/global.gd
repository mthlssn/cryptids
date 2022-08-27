extends Node

var _posicao_player_cena1 = Vector2(6,6)
var _posicao_player_cena2 = Vector2(7,23)
var _posicao_player_cena3 = Vector2(0,4)
var _posicao_player_cena4 = Vector2(2,19)
var _posicao_player_cena5 = Vector2(14,3)
var _posicao_player_cena6 = Vector2(7,19)

var _direcao_player = Vector2(1,0)

var _cena_atual = 1
var _cena_anterior = 1

var _node_demo_cena

func set_node_demo_cena(node):
	_node_demo_cena = node

func get_node_demo_cena():
	return _node_demo_cena

func set_cena_atual(cena):
	_cena_anterior = _cena_atual
	_cena_atual = cena

func get_cena_atual():
	return _cena_atual
	
func get_cena_anterior():
	return _cena_anterior

func get_posicao_player():
	match _cena_atual:
		1:
			_posicao_player_cena1 = Vector2(_posicao_player_cena2.x, _posicao_player_cena1.y)
			return _posicao_player_cena1
		2:
			match _cena_anterior:
				1:
					_posicao_player_cena2 = Vector2(_posicao_player_cena1.x, _posicao_player_cena2.y)
				3:
					_posicao_player_cena2 = Vector2(_posicao_player_cena2.x, _posicao_player_cena3.y)
			return _posicao_player_cena2
		3:
			match _cena_anterior:
				2:
					_posicao_player_cena3 = Vector2(_posicao_player_cena3.x, _posicao_player_cena2.y)
				4:
					_posicao_player_cena3 = Vector2(_posicao_player_cena4.x, _posicao_player_cena3.y)
			return _posicao_player_cena3
		4:
			match _cena_anterior:
				3:
					_posicao_player_cena4 = Vector2(_posicao_player_cena3.x , _posicao_player_cena4.y)
				5:
					_posicao_player_cena4 = Vector2(_posicao_player_cena4.x, _posicao_player_cena5.y+1)
			return _posicao_player_cena4
		5:
			match _cena_anterior:
				4:
					_posicao_player_cena5 = Vector2(_posicao_player_cena5.x, _posicao_player_cena4.y-1)
				6:
					_posicao_player_cena5 = Vector2(_posicao_player_cena6.x, _posicao_player_cena5.y)
			return _posicao_player_cena5
		6:
			_posicao_player_cena6 = Vector2(_posicao_player_cena5.x, _posicao_player_cena6.y)
			return _posicao_player_cena6

func get_direcao_player():
	return _direcao_player

func set_direcao_player(direcao):
	_direcao_player = direcao

func set_posicao_player(posicao):
	match _cena_atual:
		1:
			_posicao_player_cena1 = posicao
		2:
			_posicao_player_cena2 = posicao
		3:
			_posicao_player_cena3 = posicao
		4:
			_posicao_player_cena4 = posicao
		5:
			_posicao_player_cena5 = posicao
		6:
			_posicao_player_cena6 = posicao
			
func chamar_trocar_cena(scene_to_go):
	load("res://scenes/jogo.tscn").instance().trocar_cena(scene_to_go)
