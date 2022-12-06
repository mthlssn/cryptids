extends TileMap

enum {EMPTY = -1,  OBSTACLE, AREA, PLAYERS, OBJECT, PERSONAGEM}

onready var players_node := $players

var player_soli_mov
var direcao_soli_mov
var proxima_celula

func _ready():
	var nodes_apagados = Global.get_nodes_apagados()
	
	for node in get_children():
		if node.name == "players":
			var global_posicao_player = Global.get_posicao_players()
			var cont = 0
			
			for node_players in node.get_children():
				var posicao_player = global_posicao_player[cont]
				
				node_players.position = posicao_player
				
				set_cellv(world_to_map(node_players.position), PLAYERS)
				cont += 1
		elif node.name == "area":
			for node_area in node.get_children():
				var setar_celula = true;
				
				for nome_node_apagado in nodes_apagados:
					if nome_node_apagado == node_area.name:
						setar_celula = false
						node_area.queue_free()
				
				if setar_celula:
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
				hei_and_wid_v.x = 0
				hei_and_wid_v += Vector2(0,1)

func reposicionar_node(node, posicao, tipo):
	var primeira_posicao = node.position
	node.show()
	var width = node.get_sprite_width_tile()
	var height = node.get_sprite_height_tile()
	var posicao_inicial = posicao
	var posicao_inicial2 = primeira_posicao
	
	node.position = posicao
	
	for i in height:
		for j in width:
			set_cellv(world_to_map(primeira_posicao), -1)
			set_cellv(world_to_map(posicao), tipo)
			posicao.x += 32
			primeira_posicao.x += 32
		posicao.x = posicao_inicial.x
		primeira_posicao.x = posicao_inicial2.x
		posicao.y += 32
		primeira_posicao.y += 32

func apagar_node(node):
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
	
	var temp = Global.get_nodes_apagados()
	temp.resize(temp.size() + 1)
	temp[temp.size() - 1] = node.name
	Global.set_nodes_apagados(temp)
	
	node.queue_free()

func solicitar_movimento(player, direcao):
	player_soli_mov = player
	direcao_soli_mov = direcao
	var celula_comeco = world_to_map(player.position)
	proxima_celula = celula_comeco + direcao

	var tipo_celula_alvo = get_cellv(proxima_celula)

	match tipo_celula_alvo:
		EMPTY:
			return map_to_world(proxima_celula) + (cell_size / 2)
		PLAYERS:
			return map_to_world(proxima_celula) + (cell_size / 2)
		AREA:
			var node_area = get_node_celula(proxima_celula, true)
			if node_area.apagar:
				apagar_node(node_area)
			
			if node_area.colisao:
				node_area.colisao(self)
				
			match node_area.function:
				"mexer_arbusto":
					get_node("arbusto_grande2").dg_interacao = false
					get_node("arbusto_grande2").func_interacao = true
					get_node("arbusto_grande2/animation_player").play("mexer_arbusto")
				"atualizar_porta_frente":
					$porta_fundos1.func_interacao = true
					$porta_fundos1.dg_interacao = false
				"andar":
					return map_to_world(proxima_celula) + (cell_size / 2)
				"salvar":
					DataPlayer.salvar()

func atualizar_posicao(posicao_comeco, posicao_alvo):
	posicao_comeco = world_to_map(posicao_comeco)
	if get_cellv(posicao_comeco) != AREA:
		set_cellv(posicao_comeco, EMPTY)
		
	posicao_alvo = world_to_map(posicao_alvo)
	if get_cellv(posicao_alvo) != AREA:
		set_cellv(posicao_alvo, PLAYERS)

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"gamba":
			apagar_node(get_node("gamba"))
