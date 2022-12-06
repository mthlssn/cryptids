extends "area.gd"

func colisao(_tilemap):
	var players = get_parent().get_parent().get_node("players")
	if players.get_children().size() > 1:
		var node_maria = players.get_node("maria")
		node_maria.mostrar_exclamacao()
		node_maria.interaction = dialogo_resource
	
