extends Node

onready var animation := $animation_player

var animando = false

var pegar_pratos = false

var pegou_desenho = false

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
		#arrumar_casa2()
		#Global.set_pausar(true)
		#Global.set_mover(true)
	
	if Global.get_cena_atual() == 9:
		arrumar_casa3()

func set_animando():
	if animando:
		animando = false
	else:
		animando = true

func set_tirar_mover_false():
	Global.set_mover(true)

func arrumar_casa1():
	var nt = $tilemap
	nt.get_node("maria").interaction = load("res://data/dialogs/pt_BR/maria/maria_pegar_pratos.tres")
	nt.reposicionar_node(nt.get_node("maria"), Vector2(528, -2832), 4)
	nt.get_node("maria/sprite").frame = 10
	
	nt.reposicionar_node(nt.get_node("biscoito"), Vector2(368, -2864), 4)
	nt.get_node("biscoito/sprite").frame = 1
	
	mudar_luz("normal")

func arrumar_casa2():
	var nt = $tilemap
	
	Global.set_players(["res://scenes/personagens/biscoito.tscn", "res://scenes/personagens/maria.tscn", "res://scenes/personagens/player.tscn"])
	Global.set_posicao_players([Vector2(528,-2736), Vector2(528,-2768), Vector2(528,-2800)])
	Global.set_direcao_players([Vector2(0,-1), Vector2(-1,0), Vector2(0,1)])
	
	nt.get_node("players/player").position = Vector2(528,-2800)
	
	nt.get_node("players").arrumar_fila()
	nt.get_node("../camera").mudar_camera(true)
	
	nt.reposicionar_node(nt.get_node("maria"), Vector2(112, -2824), 4)
	nt.reposicionar_node(nt.get_node("biscoito"), Vector2(112, -2720), 4)
	
	nt.reposicionar_node(nt.get_node("area/portal15"), Vector2(-112, -2608), 1)
	nt.reposicionar_node(nt.get_node("cutscene_quarto1"), Vector2(-16, -2992), 3)
	
	nt.get_node("players/maria").interaction = load("res://data/dialogs/pt_BR/maria/nada_desenho.tres")
	nt.get_node("janela_7cena1").dialogo_resource = load("res://data/dialogs/pt_BR/objects/janela_c72.tres")
	nt.get_node("porta_quarto_maria1").dialogo_resource = load("res://data/dialogs/pt_BR/maria/maria_porta_quarto.tres")
	nt.get_node("porta_quarto_maria1").dr_personagem = true
	nt.get_node("porta_quarto_maria1").dg_interacao = false
	nt.get_node("porta_quarto_maria1").func_interacao = true
	
	nt.get_node("mesa_desenho1").func_interacao = false
	nt.get_node("mesa_desenho1").dg_interacao = true
	
	nt.get_node("bancada_baixo1").interagido = true
	
	mudar_luz("noite")

func arrumar_casa3():
	var nt = $tilemap
	
	nt.get_node("players/player").position = Vector2(-48,-3216)
	
	nt.reposicionar_node(nt.get_node("maria"), Vector2(48, -2800), 4)
	nt.get_node("maria/sprite").frame = 10
	
	nt.reposicionar_node(nt.get_node("pacote1"), Vector2(240, -2960), 3)
	
	nt.reposicionar_node(nt.get_node("cutscene_quarto1"), Vector2(-112, -2608), 3)
	nt.reposicionar_node(nt.get_node("area/portal15"), Vector2(-16, -2992), 1)
	
	nt.get_node("janela_7cena1").dialogo_resource = load("res://data/dialogs/pt_BR/objects/janela_c73.tres")
	nt.get_node("janela_9cena1").dialogo_resource = load("res://data/dialogs/pt_BR/objects/janela_c92.tres")
	
	nt.get_node("mesa_desenho1").func_interacao = false
	nt.get_node("mesa_desenho1").dg_interacao = true
	
	nt.get_node("porta_quarto_maria1").dialogo_resource = load("res://data/dialogs/pt_BR/cena_7/porta_quarto_maria.tres")
	nt.get_node("porta_quarto_maria1").dialogo_resource = load("res://data/dialogs/pt_BR/cena_7/porta_quarto_maria.tres")
	nt.get_node("porta_quarto_maria1").dr_personagem = false
	nt.get_node("porta_quarto_maria1").dg_interacao = true
	nt.get_node("porta_quarto_maria1").func_interacao = false
	
	nt.get_node("area/portal16").tipo_portal = "porta_monstro"
	nt.reposicionar_node(nt.get_node("area/barulho"), Vector2(464, -2960), 1)
	
	nt.get_node("bancada_baixo1").interagido = true
	
	#nt.get_node("cama1").func_interacao = false
	
	if Global.get_interacoes_maria() >= 5:
		nt.reposicionar_node(nt.get_node("desenho1"), Vector2(-16, -2904), 3)
		
		nt.reposicionar_node(nt.get_node("biscoito"), Vector2(-16, -2800), 4)
		nt.get_node("biscoito/sprite").frame = 4
		
		nt.get_node("porta_quarto_maria1").dialogo_resource = load("res://data/dialogs/pt_BR/cena_7/porta_quarto_maria.tres")
		nt.get_node("porta_quarto_maria1").dr_personagem = false
	else:
		nt.get_node("biscoito").interaction = load("res://data/dialogs/pt_BR/biscoito/biscoito_bravo.tres")
		nt.reposicionar_node(nt.get_node("biscoito"), Vector2(-16, -2904), 4)
		nt.get_node("biscoito/sprite").frame = 4
	
	mudar_luz("noite")

func mudar_luz(tipo_luz):
	canvas = tipo_luz
	match tipo_luz:
		"normal":
			$cenarios/cenario9/janela_fundo.texture = load("res://assets/cenarios/cen9/janela_fundo1.png")
			$canvas.color = Color("ffffff")
			$acima_dos_cenarios/fog1/luz_1.color = Color("ff7800")
			$acima_dos_cenarios/fog1/luz_2.color = Color("8f3d19")
		"escuro":
			$canvas.color = Color("8d8d8d")
		"noite":
			$cenarios/cenario9/janela_fundo.texture = load("res://assets/cenarios/cen9/janela_fundo2.png")
			$canvas.color = Color("48425a")
			$acima_dos_cenarios/fog1/luz_1.color = Color("001cff")
			$acima_dos_cenarios/fog1/luz_2.color = Color("001cff")
