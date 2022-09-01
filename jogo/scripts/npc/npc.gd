extends Node2D

# tipo da celula 3 = PLAYER
onready var type = 3 

# tamanho da sprit do player
onready var _sprite_h_and_w_tile = 1 

onready var tilemap = get_parent()

export var dividido = 1.0

# difinindo a a direção da sprite do inicio do jogo
func _ready():
	update_direcao_sprite(Global.get_direcao_player())
		
func _process(_delta):
	var direcao
	if not Transition.get_animando():
		pass

	if direcao:
		Global.set_direcao_player(direcao)
		
		# condição para girar o personagem ou fazer ele andar
		if Input.is_action_pressed("shift"):
			update_direcao_sprite(direcao)
		else:
			movimentacao(direcao)

# função que solicita movimento e e move o personagem
func movimentacao(direcao):
	update_direcao_sprite(direcao)
	
	var posicao_alvo = tilemap.solicitar_movimento(self, direcao)
	if posicao_alvo:
		mover(direcao, posicao_alvo)

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
	$AnimationPlayer.play("walk_" + string_direcao)
	
	# configura o Tween
	$Tween.interpolate_property(
		self, "position", self.position, direcao_alvo, 
		($AnimationPlayer.current_animation_length/dividido), Tween.TRANS_LINEAR
	)
	
	# começa o movimento
	$Tween.start()
	
	# suspende a execução do código até que a animação acabe
	yield($AnimationPlayer, "animation_finished")
	
	# desbloqueia a entrada de dados
	set_process(true)

# função que retorna o tamanho da sprit do player
func get_sprite_width_tile():
	return _sprite_h_and_w_tile

# função que retorna o tamanho da sprit do player
func get_sprite_height_tile():
	return _sprite_h_and_w_tile
