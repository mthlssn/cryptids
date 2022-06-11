extends "res://scripts/coisas.gd"

onready var Mapa = get_parent()

var ultima_direcao = Vector2(0,1)

# difinindo a a direção da sprite do inicio do jogo
func _ready():
	update_direcao_sprite(Vector2(0,1))
		
func _process(_delta):
	var direcao = get_direcao()

	if direcao:
		ultima_direcao = direcao
		
		# condição para girar o personagem ou fazer ele andar
		if Input.is_action_pressed("shift"):
			update_direcao_sprite(direcao)
		else:
			movimentacao(direcao)
	
	interagir()

func interagir():
	if Input.is_action_just_pressed("key_e"):
		var alvo = Mapa.world_to_map(self.position) + ultima_direcao
		var node = Mapa.get_celula_player(alvo)
		if node:
			node.interacao()

# função que solicita movimento e e move o personagem
func movimentacao(direcao):
	update_direcao_sprite(direcao)
	
	var posicao_alvo = Mapa.solicitar_movimento(self, direcao)
	if posicao_alvo:
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
			$Sprite.frame = 10
		Vector2(-1,0):
			$Sprite.frame = 7
		Vector2(0,1):
			$Sprite.frame = 1
		Vector2(0,-1):
			$Sprite.frame = 4

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
		($AnimationPlayer.current_animation_length), Tween.TRANS_LINEAR
	)
	
	# começa o movimento
	$Tween.start()
	
	# suspende a execução do código até que a animação acabe
	yield($AnimationPlayer, "animation_finished")
	
	# desbloqueia a entrada de dados
	set_process(true)
