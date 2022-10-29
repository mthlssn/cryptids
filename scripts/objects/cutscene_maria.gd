extends "area.gd"

var nt # node_tilemap
var na # node_animation_player

func colisao(tilemap):
	nt = tilemap
	na = nt.get_node("../animation_player")
	
	Global.set_mover(false)
	
	var player = nt.get_node("players/player")
	
	if player.position.y == -1008:
		na.play("empurrar_para_tras")
	else:
		na.play("empurrar_para_tras2")

func dialogo():
	DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
	DialogBox.set_node_cutscene(self)

func pausar():
	na.stop(false)

func iniciou():
	na.play("girar_maria")

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"girar_maria":
			Transition.fade(self, "", 1, "fade", true)

func func_transicao():
	nt.get_node("players").show()
			
	nt.apagar_node(nt.get_node("player"))
	nt.apagar_node(nt.get_node("maria"))
	nt.apagar_node(nt.get_node("biscoito"))
	
	Global.set_players(["res://scenes/personagens/biscoito.tscn", "res://scenes/personagens/maria.tscn", "res://scenes/personagens/player.tscn"])
	Global.set_posicao_players([Vector2(464,-976), Vector2(464,-1008), Vector2(432,-1008)])
	Global.set_direcao_players([Vector2(-1,0), Vector2(-1,0), Vector2(1,0)])
	
	nt.get_node("players").arrumar_fila()
	nt.get_node("../camera").mudar_camera()
	nt.apagar_node(self)

func esconder_players():
	nt.get_node("players").hide()
	
	var player = nt.get_node("players/player")
	player.position.y = -1008
