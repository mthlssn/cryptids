extends Node2D

# tipo da celula 5 = FOLLOWER
onready var type = 3 

onready var tilemap = get_parent()

export var velocidade = 1.0

export var nome : String
export(String, FILE) var path_images 

onready var animacao = $animation_player

export(Resource) var interaction

# difinindo a a direção da sprite do inicio do jogo
func _ready():
	update_direcao_sprite(Global.get_direcao_player())
	animacao.playback_speed = velocidade

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

func direcao_npc(direcao_alvo):
	if position.x < direcao_alvo.x:
		return Vector2(1,0)
	elif position.x > direcao_alvo.x:
		return Vector2(-1,0)
	elif position.y < direcao_alvo.y:
		return Vector2(0,1)
	elif position.y > direcao_alvo.y:
		return Vector2(0,-1)
	
# função que move o player
func mover(direcao_alvo):
	# bloqueia a entrada de dados 
	set_process(false)
	
	var direcao = direcao_npc(direcao_alvo)
	
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
	$Tween.interpolate_property(
		self, "position", self.position, direcao_alvo, 
		(animacao.current_animation_length/velocidade), Tween.TRANS_LINEAR
	)
	
	# começa o movimento
	$Tween.start()
	
	# suspende a execução do código até que a animação acabe
	yield(animacao, "animation_finished")
	
	# desbloqueia a entrada de dados
	set_process(true)

func interacao():
	if interaction:
		DialogBox.call_dialog_box(interaction.msg_queue, true, nome, path_images, interaction.reacoes)
