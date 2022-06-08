extends TileMap

enum { EMPTY = -1, PLAYER, OBSTACLE, OBJECT}

func _ready():
	var cont = 1
	var name_string = " "
	
	
	
	 
	for child in get_children():
		var node_string = "obstacle"
		node_string = node_string + String(cont)
		#print(node_string)
		#print(child)
		#print(child.get_children())
		
		if child.name == node_string:
			for teste in child.get_children():
				var pedro = + node_string + "/" + teste.name
				#var mano = teste.get_node("obstacle2/arvore_sprite")
				
				#mano = mano + "sla"
				var mano : Node2D = preload("res://scenes/teste2.tscn").instance()
				var mano2 : int = mano.get_node(pedro).texure.get_width()
				
				print(" ")
				print("A")
				print("A")
				print("A")
				print(mano)
				print(mano2)
				print("A")
				print("A")
				print("A")
				print(" ")
				
				#print($.teste.name.texture.get_width())
				#var sprite = $
				#sprite = sprite + pedro
				#print(pedro)
				var sprite2 = "sla"
				print(teste.name)
				#print(sprite)
				#print((sprite).texture.get_width())
				print(" ")
				cont += 1
		
		set_cellv(world_to_map(child.position), child.type)
		#print($obstacle1/arvore_sprite.texture.get_width())
		if child.name == "obstacle1":
			#print(child.get_children())
			var teste = child.get_children()
			#print($obstacle1/arvore_sprite.texture.get_width())
			var vec = child.position
			vec.x += 32
			set_cellv(world_to_map(vec), child.type)

func get_celula_player(posicao_em_tile):
	for node in get_children():
		if world_to_map(node.position) == posicao_em_tile:
			return node
			


func solicitar_movimento(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var celula_alvo = celula_comeco + direcao
	var tipo_celula_alvo = get_cellv(celula_alvo)
	
	print(tipo_celula_alvo)
	
	match tipo_celula_alvo:
		EMPTY:
			return atualizar_posicao_player(player, celula_comeco, celula_alvo)
		OBJECT:
			pass
			
func atualizar_posicao_player(player, celula_comeco, celula_alvo):
	set_cellv(celula_alvo, player.type)
	set_cellv(celula_comeco, EMPTY)
	
	return map_to_world(celula_alvo) + (cell_size / 2)
