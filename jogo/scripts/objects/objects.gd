extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var nome : String
export(Resource) var foto 

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var interaction

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if interaction:
		DialogBox.call_dialog_box(interaction.msg_queue, false, null, null)
	else:
		DialogBox.call_dialog_box(["Ainda não tem interação", "Desculpe :)"], true, "Thalisson", foto)
