extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var interaction
 
var texto : Array = ["opa", "novo teste", "vamo ver oq tem de errado"]

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():	
	print(texto)
	var node_pai = get_parent().get_parent()

	DialogBox.add_mensagem(interaction.msg_queue, node_pai)
	
