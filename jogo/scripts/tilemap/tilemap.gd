extends TileMap

enum { EMPTY = -1,  OBSTACLE, PORTAL, PLAYERS, OBJECT}

onready var players := $players

func _ready():
	Global.set_cena_atual(get_parent().get_cena())
	
	for node in get_children():
		if node.name == "players":
			for node_players in node.get_children():
				var posicao_player = Global.get_posicao_player() - Global.get_direcao_player()
				
				node_players.position = map_to_world(posicao_player)
				
				node_players.position.x = map_to_world(posicao_player).x + 16
				node_players.position.y = map_to_world(posicao_player).y + 16
				set_cellv(world_to_map(node_players.position), PLAYERS)
		else:
			var width = node.get_sprite_width_tile()
			var height = node.get_sprite_height_tile()
			var posicao = node.position
			
			for i in height:
				for j in width:	
					set_cellv(world_to_map(posicao), node.type)
					posicao.x += 32
				posicao.y += 32
	
	if Global.get_mover():
		players.movimentacao(Global.get_direcao_player())
		Global.set_mover(false)

func get_celula_player(alvo):
	for node in get_children():

		var width = node.get_sprite_width_tile()
		var height = node.get_sprite_height_tile()
		
		var hei_and_wid_v = Vector2(0,0)
		
		for i in height:
			for j in width:
				if (world_to_map(node.position) + hei_and_wid_v) == alvo:
					return node
				hei_and_wid_v += Vector2(1,0)
			hei_and_wid_v += Vector2(0,1)

func solicitar_movimento(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var proxima_celula = celula_comeco + direcao

	Global.set_posicao_player(celula_comeco)
	
	var tipo_celula_alvo = get_cellv(proxima_celula)
	match tipo_celula_alvo:
		EMPTY:
			return map_to_world(proxima_celula) + (cell_size / 2)
		PLAYERS:
			return map_to_world(proxima_celula) + (cell_size / 2)
		PORTAL:
			verificar_sair_tela(direcao)
			return map_to_world(proxima_celula) + (cell_size / 2)

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
	
func atualizar_posicao(posicao_comeco, posicao_alvo):
	posicao_comeco = world_to_map(posicao_comeco)
	if get_cellv(posicao_comeco) != PORTAL:
		set_cellv(posicao_comeco, EMPTY)
		
	posicao_alvo = world_to_map(posicao_alvo)
	if get_cellv(posicao_alvo) != PORTAL:
		set_cellv(posicao_alvo, PLAYERS)

