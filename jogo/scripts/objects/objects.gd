extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var interaction

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if interaction:
		DialogBox.add_mensagem(interaction.msg_queue)
	else:
		DialogBox.add_mensagem(["Ainda não tem interação", "Reclama com o Thalisson!", "Vlw :)"])
