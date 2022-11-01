extends Node

onready var animation := $animation_player

var animando = false

var pegar_pratos = false

var canvas = "normal"

func _ready():
	Global.set_node_demo(self)
	mudar_luz("normal")
	
	if Global.get_novo_jogo():
		animation.play("iniciar")
	else:
		set_tirar_mover_false()
	
	if Global.get_cena_atual() == 7:
		arrumar_casa1()

func set_animando():
	if animando:
		animando = false
	else:
		animando = true

func set_tirar_mover_false():
	Global.set_mover(true)

func arrumar_casa1():
	var nt = get_node("tilemap")
	nt.get_node("maria").interaction = load("res://data/dialogs/pt_BR/maria/maria_pegar_pratos.tres")
	nt.reposicionar_node(nt.get_node("maria"), Vector2(528, -2832), 4)
	nt.get_node("maria/sprite").frame = 10
			
	nt.reposicionar_node(nt.get_node("biscoito"), Vector2(368, -2864), 4)
	nt.get_node("biscoito/sprite").frame = 1
	
	mudar_luz("normal")

func arrumar_casa2():
	var nt = get_node("tilemap")
	nt.reposicionar_node(nt.get_node("maria"), Vector2(48, -2800), 4)
	nt.get_node("maria/sprite").frame = 10
	
	nt.reposicionar_node(nt.get_node("pacote1"), Vector2(240, -2960), 3)
	
	if Global.get_interacoes_maria() == 2:
		nt.reposicionar_node(nt.get_node("desenho1"), Vector2(-16, -2904), 3)
		
		nt.reposicionar_node(nt.get_node("biscoito"), Vector2(-16, -2800), 4)
		nt.get_node("biscoito/sprite").frame = 4
		
	else:
		nt.reposicionar_node(nt.get_node("biscoito"), Vector2(-16, -2904), 4)
		nt.get_node("biscoito/sprite").frame = 4
	
	mudar_luz("noite")

func mudar_luz(tipo_luz):
	canvas = tipo_luz
	match tipo_luz:
		"normal":
			$canvas.color = Color("ffffff")
			$acima_dos_cenarios/fog1/luz_1.color = Color("ff7800")
			$acima_dos_cenarios/fog1/luz_2.color = Color("8f3d19")
		"escuro":
			$canvas.color = Color("8d8d8d")
		"noite":
			$canvas.color = Color("48425a")
			$acima_dos_cenarios/fog1/luz_1.color = Color("001cff")
			$acima_dos_cenarios/fog1/luz_2.color = Color("001cff")
