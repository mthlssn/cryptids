extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile
