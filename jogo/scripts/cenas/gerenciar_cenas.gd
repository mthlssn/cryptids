extends Node2D

export var _cena = 0

export (String, FILE, "*.tscn") var _cena_esquerda = "nada"
export (String, FILE, "*.tscn") var _cena_direita = "nada"
export (String, FILE, "*.tscn") var _cena_superior = "nada"
export (String, FILE, "*.tscn") var _cena_inferior = "nada"

var _caminho_cena

func get_cena():
	return _cena

func mudar_cena(lado):
	match lado:
		0:
			_caminho_cena = _cena_esquerda
		1:
			_caminho_cena = _cena_direita
		2:
			_caminho_cena = _cena_superior
		3:
			_caminho_cena = _cena_inferior
	
	Transition.fade_into(_caminho_cena)

