extends TileMap

enum { EMPTY = -1, OBSTACLE, PLAYER, OBJECT}

onready var _top_left = $Limites/top_left
onready var _bottom_right = $Limites/bottom_right

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
	
	var sair = verificar_sair_tela(proxima_celula)
	
	if sair == "false":
		var tipo_celula_alvo = get_cellv(proxima_celula)
		match tipo_celula_alvo:
			EMPTY:
				return atualizar_posicao_player(player, celula_comeco, proxima_celula)
	else:
		print(sair)
			
func verificar_sair_tela(proxima_celula):
	var node = get_parent().get_children()
	var tamanho = node[6].get_tamanho_camera_y()
	var prox_pos = proxima_celula * 32
	
	if prox_pos.y < tamanho:
		print("Mano deu certo")
		node[6].mudar_posicao_camera()
		return "saiu por cima"
	else:
		print("Ta dentro ainda")
		return "false"
	
func atualizar_posicao_player(player, celula_comeco, celula_alvo):
	set_cellv(celula_alvo, player.type)
	set_cellv(celula_comeco, EMPTY)
	
	return map_to_world(celula_alvo) + (cell_size / 2)
