extends "area.gd"

var nt # node_tilemap

func colisao(tilemap):
	nt = tilemap
	
	var node_maria = nt.get_node("maria")
	var node_mel = nt.get_node("mel")
	
	nt.get_node("players").hide()
	
	Global.set_mover(false)
	
	node_maria.position.y = node_maria.position.y + 32
	node_mel.position.y = node_mel.position.y - 32
	
	nt.get_node("players").mover(node_maria, node_maria.get_node("animation_player"), node_maria.get_node("tween"), Vector2(-1, 0), Vector2(node_maria.position.x - 32, node_maria.position.y), 1)
	nt.get_node("players").mover(node_mel, node_mel.get_node("animation_player"), node_mel.get_node("tween"), Vector2(-1, 0), Vector2(node_mel.position.x - 32, node_mel.position.y), 1)
	
	nt.get_node("../animation_player").play("cutscene_maria")

func _on_animation_player_animation_finished(_anim_name):
	Global.set_mover(true)

func dialogo():
	DialogBox.call_dialog_box(true, dialogo_resource[0].msg_queue, dialogo_resource[0].nome, dialogo_resource[0].imagens)
