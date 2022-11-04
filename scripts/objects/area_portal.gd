extends "area.gd"

export var proxima_camera : int = 0
var nt # node_tilemap

export var tipo_portal : String

func colisao(tilemap):
	nt = tilemap
	Global.set_cena_atual(proxima_camera)
	Transition.fade(self, "", nt.get_node("players").velocidade, "fade", true)
	
func func_transicao():
	if tipo_portal == "porta" or tipo_portal == "casa_entrar":
		nt.get_parent().get_node("camera").mudar_camera(true)
	else:
		nt.get_parent().get_node("camera").mudar_camera(false)
	
	var players = nt.get_node("players").get_children()
	
	var distancia
	match tipo_portal:
		"floresta":
			distancia = 64
		"casa_entrar":
			nt.get_node("maria").interaction = load("res://data/dialogs/pt_BR/maria/maria_pegar_pratos.tres")
			nt.reposicionar_node(nt.get_node("maria"), Vector2(528, -2832), 4)
			nt.get_node("maria/sprite").frame = 10
			
			nt.reposicionar_node(nt.get_node("biscoito"), Vector2(368, -2864), 4)
			nt.get_node("biscoito/sprite").frame = 1
			
			distancia = 160
		"casa_sair":
			distancia = 160
		"porta":
			if name == "portal13" and Global.get_node_demo().canvas == "normal":
				Global.get_node_demo().mudar_luz("escuro")
			elif name == "portal14" and Global.get_node_demo().canvas == "escuro":
				Global.get_node_demo().mudar_luz("normal")
			
			distancia = 192
		"porta_monstro":
			distancia = 192
			yield(Transition, "transicao_acabou")
			Global.get_node_demo().get_node("animation_player").play("vulto_cena7")
			tipo_portal = "porta"
			
	for node in players :
		node.position = players[players.size()-1].position + (nt.direcao_soli_mov * distancia)
	
	nt.player_soli_mov.position = nt.player_soli_mov.position + (nt.direcao_soli_mov * 32)
	
	return nt.map_to_world(nt.proxima_celula + (nt.direcao_soli_mov * 2)) + (nt.cell_size / 2)
