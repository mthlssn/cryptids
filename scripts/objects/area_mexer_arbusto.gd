extends "area.gd"

func colisao(tilemap):
	tilemap.get_node("arbusto_grande2/animation_player").play("mexer_arbusto")
