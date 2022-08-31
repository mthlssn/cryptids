extends TileMap

enum { EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT, NPC, FOLLOW}
func _ready():
	Global.set_cena_atual(get_parent().get_cena())
	
	for node in get_children():
		var width = node.get_sprite_width_tile()
		var height = node.get_sprite_height_tile()
		var posicao = node.position

		if node.name != "player":
			for i in height:
				for f in width:	
					set_cellv(world_to_map(posicao), node.type)
					if width > 1:
						posicao.x += 32
				posicao.y += 32
		else:
			var player = get_node("player")
			var posicao_player = Global.get_posicao_player()
			
			player.position.x = map_to_world(posicao_player).x + 16
			player.position.y = map_to_world(posicao_player).y + 16
			set_cellv(posicao_player, player.type)

func get_celula_player(alvo):
	for node in get_children():
		var width = node.get_sprite_width_tile()
		var widthv = Vector2(0,0)
				
		for i in width:
			if (world_to_map(node.position) + widthv) == alvo:
				return node
			widthv += Vector2(1,0)

func solicitar_movimento(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var proxima_celula = celula_comeco + direcao

	Global.set_posicao_player(celula_comeco)
	
	var tipo_celula_alvo = get_cellv(proxima_celula)
	match tipo_celula_alvo:
		EMPTY:
			return atualizar_posicao_player(player, celula_comeco, proxima_celula)
		PORTAL:
			verificar_sair_tela(direcao)
			
func verificar_sair_tela(direcao):
	var node_pai = get_parent()
	match direcao:
		Vector2(-1,0):
			node_pai.mudar_cena(0)
		Vector2(1,0):
			node_pai.mudar_cena(1)
		Vector2(0,-1):
			node_pai.mudar_cena(2)
		Vector2(0,1):	
			node_pai.mudar_cena(3)
	
func atualizar_posicao_player(player, celula_comeco, celula_alvo):
	set_cellv(celula_alvo, player.type)
	set_cellv(celula_comeco, EMPTY)
	
	return map_to_world(celula_alvo) + (cell_size / 2)
