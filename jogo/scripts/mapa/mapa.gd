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

func get_celula_player(alvo):
	print(alvo)
	for node in get_children():
		if node.name == "Ysort":
			for node2 in node.get_children():
				var width = node2.get_sprite_width_tile()
				var widthv = Vector2(0,0)
				
				for i in width:
					if (world_to_map(node2.position) + widthv) == alvo:
						return node2
					widthv += Vector2(1,0)

func solicitar_movimento(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var proxima_celula = celula_comeco + direcao
	var tipo_celula_alvo = get_cellv(proxima_celula)
	
	match tipo_celula_alvo:
		EMPTY:
			return atualizar_posicao_player(player, celula_comeco, proxima_celula)
			
func celula_alvo(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var celula_alvo = celula_comeco + direcao
	
	return celula_alvo

func atualizar_posicao_player(player, celula_comeco, celula_alvo):
	set_cellv(celula_alvo, player.type)
	set_cellv(celula_comeco, EMPTY)
	
	return map_to_world(celula_alvo) + (cell_size / 2)
