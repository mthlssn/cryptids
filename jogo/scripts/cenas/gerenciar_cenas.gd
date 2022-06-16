extends Node2D

export (String, FILE, "*.tscn") var _cena_esquerda = "nada"
export (String, FILE, "*.tscn") var _cena_direita = "nada"
export (String, FILE, "*.tscn") var _cena_superior = "nada"
export (String, FILE, "*.tscn") var _cena_inferior = "nada"

func mudar_cena_p_esquerda():
	get_tree().change_scene(_cena_esquerda)
	print("demo_cena: esquerda")
	
func mudar_cena_p_direita():
	get_tree().change_scene(_cena_direita)
	print("demo_cena: direita")
	
func mudar_cena_p_superior():
	get_tree().change_scene(_cena_superior)
	print("demo_cena: superior")
	
func mudar_cena_p_inferior():
	get_tree().change_scene(_cena_inferior)
	print("demo_cena: inferior")
