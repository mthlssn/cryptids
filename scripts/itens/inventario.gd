extends Node

var _inventario : Array

#item = nome, descrição, alvo

func _ready():
	#add_item_inventario(["Desenho", "- Desenho da Maria.\n\n- Um desenho.\n\n- só q da Maria.", "todos_aliados"])
	pass

func get_inventario():
	return _inventario

func set_inventario(inventario):
	_inventario = inventario

func get_item_inventario(item_nome):
	for item in _inventario:
		if item[0] == item_nome:
			return item

func add_item_inventario(item):
	_inventario.resize(_inventario.size() + 1)
	_inventario[_inventario.size() - 1] = item

func usar_item1(alvo, node_combate):
	var texto
	
	alvo.get_skills_player()
	
	var temp = alvo.get_skills_player()
	if temp[2] == "Amigos":
		texto = ["Você ja aprendeu AMIGOS."]
	else:
		temp[2] = "Amigos"
		texto = ["Nasce uma faísca de coragem, não estamos a sós.", "Aprendeu AMIGOS."]
		
		var temp2 = node_combate.personagens.duplicate()
		
		temp2.resize(4)
		
		temp2[3] = temp2[1]
		
		temp2[1] = load("res://scripts/combate/fichas/ficha_maria.gd").new()
		temp2[1].abrir_ficha(node_combate)
		node_combate.get_node("personagens/maria/barra_vida").max_value = temp2[1].get_ficha().get_atri_apli("hp")
		node_combate.get_node("personagens/maria/barra_energia").max_value = temp2[1].get_ficha().get_atri_apli("eng")
		
		temp2[2] = load("res://scripts/combate/fichas/ficha_biscoito.gd").new()
		temp2[2].abrir_ficha(node_combate)
		node_combate.get_node("personagens/biscoito/barra_vida").max_value = temp2[2].get_ficha().get_atri_apli("hp")
		node_combate.get_node("personagens/biscoito/barra_energia").max_value = temp2[2].get_ficha().get_atri_apli("eng")
		
		node_combate.node_p.montar_personagens(temp2.duplicate())
		
		node_combate.set_ordem(node_combate.gerar_ordem(temp2.duplicate()))
		
		node_combate.personagens = temp2.duplicate()
		
		node_combate.set_vez(-1)
		
	alvo.set_skills_player(temp) 
	
	node_combate.set_node_vez(null)
	return texto
