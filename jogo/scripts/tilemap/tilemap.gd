extends TileMap

enum { EMPTY = -1, OBSTACLE, PLAYER, OBJECT}

func _ready():
	Jogo.set_cena_atual(get_parent().get_cena())
	
	for node in get_children():
		var width = node.get_sprite_width_tile()
		var posicao = node.position

		if node.name != "player":
			for i in width:
				set_cellv(world_to_map(posicao), node.type)
				posicao.x += 32
		else:
			var player = get_node("player")
			var posicao_player = Jogo.get_posicao_player()
			
			player.position.x = map_to_world(posicao_player).x + 16
			player.position.y = map_to_world(posicao_player).y + 16
			set_cellv(posicao_player, player.type)

func get_celula_player(alvo):
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

	Jogo.set_posicao_player(celula_comeco)
	
	if not verificar_sair_tela(proxima_celula):
		var tipo_celula_alvo = get_cellv(proxima_celula)
		match tipo_celula_alvo:
			EMPTY:
				return atualizar_posicao_player(player, celula_comeco, proxima_celula)
			
func verificar_sair_tela(proxima_celula):
	var node_pai = get_parent()
	var node_camera = node_pai.get_node("camera")
	var limite = node_camera.get_limite_cam()
			
	if proxima_celula.x < (limite[0] / 32):
		node_pai.mudar_cena(1)
	elif proxima_celula.x > ((limite[1]) / 32):
		node_pai.mudar_cena(2)
	elif proxima_celula.y < (limite[2] / 32):
		node_pai.mudar_cena(3)
	elif proxima_celula.y > ((limite[3]) / 32):
		node_pai.mudar_cena(4)
	else:
		return false
	
func atualizar_posicao_player(player, celula_comeco, celula_alvo):
	set_cellv(celula_alvo, player.type)
	set_cellv(celula_comeco, EMPTY)
	
	return map_to_world(celula_alvo) + (cell_size / 2)
