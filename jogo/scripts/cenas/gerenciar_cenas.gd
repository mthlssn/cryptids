extends Node2D

export var _cena = 0

export (String, FILE, "*.tscn") var _cena_esquerda = "nada"
export (String, FILE, "*.tscn") var _cena_direita = "nada"
export (String, FILE, "*.tscn") var _cena_superior = "nada"
export (String, FILE, "*.tscn") var _cena_inferior = "nada"

func get_cena():
	return _cena

func mudar_cena_p_esquerda():
	# o if é só para tirar os alertas
	if get_tree().change_scene(_cena_esquerda) == 0:
		pass
	
func mudar_cena_p_direita():
	if get_tree().change_scene(_cena_direita) == 0:
		pass
	
func mudar_cena_p_superior():
	if get_tree().change_scene(_cena_superior) == 0:
		pass
	
func mudar_cena_p_inferior():
	if get_tree().change_scene(_cena_inferior) == 0:
		pass
