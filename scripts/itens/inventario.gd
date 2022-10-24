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
	var texto = "Nasce uma faísca de coragem, não estamos a sós. Aprendeu AMIGOS."
	
	alvo.get_skills_player()
	
	var temp = alvo.get_skills_player()
	temp[2] = "Amigos"
	alvo.set_skills_player(temp) 
	
	node_combate.set_node_vez(null)
	return texto
