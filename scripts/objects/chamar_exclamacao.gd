extends "area.gd"

func colisao(_tilemap):
	var node_maria = get_parent().get_parent().get_node("players").get_node("maria")
	node_maria.mostrar_exclamacao()
