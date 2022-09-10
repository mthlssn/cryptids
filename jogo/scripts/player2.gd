extends Node2D

# tipo da celula 3 = PLAYER
onready var type = 3 

onready var tilemap = get_parent()

# ideal = 1.3
export var velocidade = 1.0

onready var _sprite_h_and_w_tile = 1 

onready var animacao = $animation_player
onready var tween = $tween

# difinindo a a direção da sprite do inicio do jogo
func _ready():
	update_direcao_sprite(Global.get_direcao_player())
	animacao.playback_speed = velocidade

func _process(_delta):
	var direcao
	if not Transition.get_animando():
		direcao = get_direcao()
		
	if direcao:
		Global.set_direcao_player(direcao)
		
		# condição para girar o personagem ou fazer ele andar
		if Input.is_action_pressed("shift"):
			update_direcao_sprite(direcao)
		else:
			movimentacao(direcao)
	
	interagir()

func interagir():
	if Input.is_action_just_pressed("key_e"):
		var alvo = tilemap.world_to_map(self.position) + Global.get_direcao_player()
		var node = tilemap.get_celula_player(alvo)
		if node:
			node.interacao()

# função que solicita movimento e e move o personagem
func movimentacao(direcao):
	update_direcao_sprite(direcao)
	
	var posicao_alvo = tilemap.solicitar_movimento(self, direcao)
	if posicao_alvo:
		Global.set_ultima_posicao_player(self.position)
		mover(direcao, posicao_alvo)

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
func update_direcao_sprite(direcao):
	match direcao:
		Vector2(1,0):
			$sprite.frame = 10
		Vector2(-1,0):
			$sprite.frame = 7
		Vector2(0,1):
			$sprite.frame = 1
		Vector2(0,-1):
			$sprite.frame = 4

# função que move o player
func mover(direcao, direcao_alvo):
	# bloqueia a entrada de dados 
	set_process(false)
	
	# guarda o nome da animação
	var string_direcao: String
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
		self, "position", self.position, direcao_alvo, 
		(animacao.current_animation_length/velocidade), Tween.TRANS_LINEAR
	)
	
	# começa o movimento
	tween.start()
	
	# suspende a execução do código até que a animação acabe
	yield(animacao, "animation_finished")
	
	# desbloqueia a entrada de dados
	set_process(true)

# função que retorna o tamanho da sprit do player
func get_sprite_width_tile():
	return _sprite_h_and_w_tile

# função que retorna o tamanho da sprit do player
func get_sprite_height_tile():
	return _sprite_h_and_w_tile

func _on_AnimationPlayer_animation_started(anim_name):
	tilemap.call_followers()
	
	if anim_name:
		pass
