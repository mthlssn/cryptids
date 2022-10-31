extends "area.gd"

var nt # node_tilemap
var na # node_animation_player

func colisao(tilemap):
	nt = tilemap
	na = nt.get_node("../animation_player")
	
	Global.set_mover(false)
	Global.set_pausar(false)
	
	var player = nt.get_node("players").get_children()
	var temp = player[player.size()-1].position.x
	
	na.play("chegar_portao1")
	
	if temp == 208:
		na.play("chegar_portao1")
	elif temp == 240:
		na.play("chegar_portao2")
	elif temp == 272:
		na.play("chegar_portao3")

func dialogo():
	DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
	
	yield(DialogBox, "dialogo_acabou")
	Global.set_mover(false)
	
	na.play("entrar_casa")

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"entrar_casa":
			Transition.fade(self, "", 0.5, "fade", true)

func func_transicao():
	nt.get_node("players").show()
			
	nt.get_node("player").position = Vector2(272, -1328)
	nt.get_node("maria").position = Vector2(272, -1328)
	nt.get_node("biscoito").position = Vector2(272, -1328)
	
	nt.set_cellv(Vector2(7, -77), -1)
	nt.reposicionar_node(nt.get_node("area/dg_noite1"), Vector2(176, -1872) ,1)
	
	Global.set_players(["res://scenes/personagens/player.tscn"])
	Global.set_posicao_players([Vector2(240,-2384)])
	Global.set_direcao_players([Vector2(0,-1)])
	
	var player = nt.get_node("players/player")
	player.position = Vector2(240,-2384)
	
	nt.get_node("players").arrumar_fila()
	nt.get_node("../camera").mudar_camera(false)
	
	Global.set_pausar(true)
	
	nt.apagar_node(self)

func esconder_players():
	nt.get_node("players").hide()
