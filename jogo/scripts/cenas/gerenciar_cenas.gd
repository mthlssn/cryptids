extends Node2D

export var _cena = 0

export (String, FILE, "*.tscn") var _cena_esquerda = "nada"
export (String, FILE, "*.tscn") var _cena_direita = "nada"
export (String, FILE, "*.tscn") var _cena_superior = "nada"
export (String, FILE, "*.tscn") var _cena_inferior = "nada"

func _ready():
	Jogo.set_node(self)

func get_cena():
	return _cena

func mudar_cena(lado):
	match lado:
		1:
			Transition.fade_into(_cena_esquerda)
		2:
			Transition.fade_into(_cena_direita)
		3:
			Transition.fade_into(_cena_superior)
		4:
			Transition.fade_into(_cena_inferior)
