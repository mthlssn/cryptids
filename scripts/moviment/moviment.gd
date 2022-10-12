extends Node

enum {SPRITE, ANIMATION_PLAYER, TWEEN, REMOTE_TRANSFORM}

onready var _sprite_h_and_w_tile = 1 

onready var tilemap = get_parent()

export(Array, String, FILE, "*.tscn") var players
export(Array, Vector2) var posi_players
export(Array, Vector2) var dire_players

# ideal = 1.3
export var velocidade = 1.3

var nodes_player : Array
 
var controlar

var ultima_posi

# difinindo a a direção da sprite do inicio do jogo
func _ready():
	if Global.get_players() == []:
		for i in posi_players.size():
			posi_players[i] = posi_players[i] * 32
			
			posi_players[i].x += 16
			posi_players[i].y += 16
		
		Global.set_players(players)
		Global.set_posicao_players(posi_players)
		Global.set_direcao_players(dire_players)
	else:
		players = Global.get_players()
	
	for i in players.size():
		var path_scenes = players[i]
		
		var scenes = load(path_scenes)
		var instance = scenes.instance()
		add_child(instance)

	players = get_children()
	
	controlar = players.size() - 1
	
	nodes_player = get_children()
	
	var remote_transform = RemoteTransform2D.new()
	players[controlar].add_child(remote_transform)
	
	var camera_path = get_parent().get_parent().get_node("camera").get_path()
	
	dire_players = Global.get_direcao_players()
	
	for i in players.size():
		var temp : Array = players[i].get_children()
		nodes_player[i] = temp
		nodes_player[i][ANIMATION_PLAYER].playback_speed = velocidade
		update_direcao_sprite(nodes_player[i][SPRITE], dire_players[i])
		
	nodes_player[controlar][REMOTE_TRANSFORM].set_remote_node(camera_path)
	
func _process(_delta):
	var direcao
	if not Transition.get_animando():
		direcao = get_direcao()
		
	if direcao:
		dire_players.resize(nodes_player.size())
		dire_players[controlar] = direcao
		Global.set_direcao_players(dire_players)
		
		# condição para girar o personagem ou fazer ele andar
		if Input.is_action_pressed("shift"):
			update_direcao_sprite(nodes_player[controlar][SPRITE], direcao)
		else:
			movimentacao(direcao)
	
	interagir()

func interagir():
	if Input.is_action_just_pressed("key_e"):
		var alvo = tilemap.world_to_map(players[controlar].position) + dire_players[controlar]
		var node = tilemap.get_node_celula(alvo, false)

		if node and node.type != 1:
			node.interacao()

# função que solicita movimento e e move o personagem
func movimentacao(direcao):
	update_direcao_sprite(nodes_player[controlar][SPRITE], direcao)
	
	var posicao_alvo = tilemap.solicitar_movimento(players[controlar], direcao)
	if posicao_alvo:
		posi_players.resize(nodes_player.size())
		for i in controlar+1:
			var cont = controlar - i 
			
			if cont != controlar:
				direcao = (ultima_posi - players[cont].position) / 32
				posicao_alvo = ultima_posi
				dire_players[cont] = direcao
			
			posi_players[cont] = posicao_alvo
			mover(players[cont], nodes_player[cont][ANIMATION_PLAYER], nodes_player[cont][TWEEN], direcao, posicao_alvo, cont)
			tilemap.atualizar_posicao(players[cont].position, posicao_alvo)
		
		Global.set_posicao_players(posi_players)

# função que retorna a direção
func get_direcao():
	# salvando a direção de acordo com oq o usuário digitou
	var direcao: Vector2 = Vector2(
		int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
		int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	)
	
	# somando o eixo X e Y do vetor
	var soma_direcao = direcao.x + direcao.y
	
	# condição para não ser possível andar nas diagonais
	if soma_direcao == -2 || soma_direcao == 2 || soma_direcao == 0:
		return
	else:
		return direcao

# função que gira a sprite
func update_direcao_sprite(sprite, direcao):
	match direcao:
		Vector2(1,0):
			sprite.frame = 10
		Vector2(-1,0):
			sprite.frame = 7
		Vector2(0,1):
			sprite.frame = 1
		Vector2(0,-1):
			sprite.frame = 4

# função que move o player
func mover(var_self, animacao, tween, direcao, posicao_alvo, cont):
	ultima_posi = var_self.position
	
	# bloqueia a entrada de dados 
	set_process(false)
	
	var temp
	temp = direcao.x + direcao.y
	
	# guarda o nome da animação
	var string_direcao: String
	if temp == -1 or temp == 1:
		match direcao:
			Vector2(1,0):
				string_direcao = "right"
			Vector2(-1,0):
				string_direcao = "left"
			Vector2(0,1):
				string_direcao = "down"
			Vector2(0,-1):
				string_direcao = "up"
		
		# roda a animação
		animacao.play("walk_" + string_direcao)
		
		# configura o Tween
		tween.interpolate_property(
			var_self, "position", var_self.position, posicao_alvo, 
			(animacao.current_animation_length/velocidade), Tween.TRANS_LINEAR
		)
		
		# começa o movimento
		tween.start()
	
	# suspende a execução do código até que a animação acabe
	if cont == 0:
		yield(nodes_player[controlar][ANIMATION_PLAYER], "animation_finished")
		
	# desbloqueia a entrada de dados
	set_process(true)

# função que retorna o tamanho da sprit do player
func get_sprite_width_tile():
	return _sprite_h_and_w_tile

# função que retorna o tamanho da sprit do player
func get_sprite_height_tile():
	return _sprite_h_and_w_tile
