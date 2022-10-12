extends "area.gd"

export var proxima_camera : int = 0
var nt # node_tilemap

func colisao(tilemap):
	nt = tilemap
	Global.set_cena_atual(proxima_camera)
	Transition.fade(self, "", nt.get_node("players").velocidade, "fade")
	
func func_transicao():
	nt.get_parent().get_node("camera").mudar_camera()
	
	var players = nt.get_node("players").get_children()
	for node in players :
		node.position = players[players.size()-1].position + (nt.direcao_soli_mov * 64)
		
	nt.player_soli_mov.position = nt.player_soli_mov.position + (nt.direcao_soli_mov * 32)
	
	return nt.map_to_world(nt.proxima_celula + (nt.direcao_soli_mov * 2)) + (nt.cell_size / 2)
