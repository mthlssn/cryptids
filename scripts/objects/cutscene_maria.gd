extends "area.gd"

var nt # node_tilemap
var na # node_animation_player

var num_dialogo
var verificar_num_dialogo = false

var key_

func _process(_delta):
	if verificar_num_dialogo:
		if num_dialogo < DialogBox.get_cont():
			print("Entrou: ", num_dialogo)
			
			na.play("girar_maria")
			num_dialogo = DialogBox.get_cont()
			verificar_num_dialogo = false

func colisao(tilemap):
	nt = tilemap
	na = nt.get_node("../animation_player")
	
	#var node_maria = nt.get_node("maria")
	#var node_mel = nt.get_node("mel")
	
	Global.set_mover(false)
	
	#node_maria.position.y = node_maria.position.y + 32
	#node_mel.position.y = node_mel.position.y - 32
	
	#nt.get_node("players").mover(node_maria, node_maria.get_node("animation_player"), node_maria.get_node("tween"), Vector2(-1, 0), Vector2(node_maria.position.x - 32, node_maria.position.y), 1)
	#nt.get_node("players").mover(node_mel, node_mel.get_node("animation_player"), node_mel.get_node("tween"), Vector2(-1, 0), Vector2(node_mel.position.x - 32, node_mel.position.y), 1)
	
	nt.get_node("players").hide()
	na.play("empurrar_para_tras")

func dialogo():
	na.play("girar_maria")
	DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
	num_dialogo = DialogBox.get_cont()

func pausar():
	na.stop(false)
	verificar_num_dialogo = true

func _on_animation_player_animation_started(_anim_name):
	print("começou")

func _on_animation_player_animation_finished(_anim_name):
	print("ACABOUUUUUUUUUu")
	Global.set_mover(true)
	nt.limpar_area(self)
