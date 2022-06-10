extends TileMap

enum { EMPTY = -1, OBSTACLE, PLAYER, OBJECT}

func _ready():
	for child in get_children():
		if child.name == "Ysort":
			for child2 in child.get_children():
				var width = child2.get_sprite_width_tile()
				var posicao = child2.position

				for i in width:
					set_cellv(world_to_map(posicao), child2.type)
					posicao.x += 32
		else:
			set_cellv(world_to_map(child.position), child.type)

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
