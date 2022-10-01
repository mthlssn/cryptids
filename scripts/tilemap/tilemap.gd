extends TileMap

enum {EMPTY = -1,  OBSTACLE, AREA, PLAYERS, OBJECT}

onready var players := $players

func _ready():
	Global.set_cena_atual(get_parent().get_cena())
	
	for node in get_children():
		if node.name == "players":
			for node_players in node.get_children():
				var direcao_player = Global.get_direcao_player()
				var posicao_player
				if direcao_player.x != 0:
					posicao_player = Global.get_posicao_player() - direcao_player
				elif direcao_player.y != 0:
					posicao_player = Global.get_posicao_player() - direcao_player
				
				node_players.position = map_to_world(posicao_player)
				
				node_players.position.x = map_to_world(posicao_player).x + 16
				node_players.position.y = map_to_world(posicao_player).y + 16
				set_cellv(world_to_map(node_players.position), PLAYERS)
		elif node.name == "area":
			for node_area in node.get_children():
				var width = node_area.get_sprite_width_tile()
				var height = node_area.get_sprite_height_tile()
				var posicao = node_area.position
				var posicao_inicial = posicao
				
				for i in height:
					for j in width:
						set_cellv(world_to_map(posicao), node_area.type)
						posicao.x += 32
					posicao.x = posicao_inicial.x
					posicao.y += 32

		else:
			var width = node.get_sprite_width_tile()
			var height = node.get_sprite_height_tile()
			var posicao = node.position
			var posicao_inicial = posicao
			
			for i in height:
				for j in width:	
					set_cellv(world_to_map(posicao), node.type)
					posicao.x += 32
				posicao.x = posicao_inicial.x
				posicao.y += 32
	
	if Global.get_mover():
		players.movimentacao(Global.get_direcao_player())
		Global.set_mover(false)

func get_node_celula(alvo, area):
	for node in get_children():
		if node.name == "players":
			for node_players in node.get_children():
				if world_to_map(node_players.position) == alvo:
					if not area:
						return node_players
		elif node.name == "area":
			for node_area in node.get_children():
				var width = node_area.get_sprite_width_tile()
				var height = node_area.get_sprite_height_tile()
				
				var hei_and_wid_v = Vector2(0,0)
				
				for i in height:
					for j in width:
						if (world_to_map(node_area.position) + hei_and_wid_v) == alvo:
							return node_area
						hei_and_wid_v += Vector2(1,0)
					hei_and_wid_v.x = 0
					hei_and_wid_v += Vector2(0,1)
		else:
			var width = node.get_sprite_width_tile()
			var height = node.get_sprite_height_tile()
			
			var hei_and_wid_v = Vector2(0,0)
			
			for i in height:
				for j in width:
					if (world_to_map(node.position) + hei_and_wid_v) == alvo:
						if not area:
							return node
					hei_and_wid_v += Vector2(1,0)
				hei_and_wid_v += Vector2(0,1)

func limpar_area(node):
	var width = node.get_sprite_width_tile()
	var height = node.get_sprite_height_tile()
	var posicao = node.position
	var posicao_inicial = posicao
	
	for i in height:
		for j in width:	
			set_cellv(world_to_map(posicao), -1)
			posicao.x += 32
		posicao.x = posicao_inicial.x
		posicao.y += 32
		
	node.queue_free()

func solicitar_movimento(player, direcao):
	var celula_comeco = world_to_map(player.position)
	var proxima_celula = celula_comeco + direcao

	Global.set_posicao_player(celula_comeco)

	var tipo_celula_alvo = get_cellv(proxima_celula)
	print(tipo_celula_alvo)
	match tipo_celula_alvo:
		EMPTY:
			return map_to_world(proxima_celula) + (cell_size / 2)
		PLAYERS:
			return map_to_world(proxima_celula) + (cell_size / 2)
		AREA:
			var node_area = get_node_celula(proxima_celula, true)
			var funcao_node = node_area.function
			var apagar = node_area.apagar
			
			if apagar:
				limpar_area(node_area)
			
			match funcao_node:
				"verificar_sair_tela":
					verificar_sair_tela(direcao)
					return map_to_world(proxima_celula) + (cell_size / 2)
				"mexer_arbusto":
					print("meexe ai arbusto")
				"mexeu_arbusto_nao":
					var interaction : Resource = load("res://data/dialogs/pt_BR/cena_3/saida_de_baixo.tres")
					DialogBox.call_dialog_box(true, interaction.msg_queue, interaction.nome, interaction.imagens)

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
	if get_cellv(posicao_comeco) != AREA:
		set_cellv(posicao_comeco, EMPTY)
		
	posicao_alvo = world_to_map(posicao_alvo)
	if get_cellv(posicao_alvo) != AREA:
		set_cellv(posicao_alvo, PLAYERS)

