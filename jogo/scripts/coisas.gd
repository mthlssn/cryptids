extends Node

enum CELL_TYPES{EMPYT = -1,  OBSTACLE, PLAYER, OBJECT }
export(CELL_TYPES) var type = CELL_TYPES.PLAYER

export var _sprite_width_tile = 1 

func get_sprite_width_tile():
	return _sprite_width_tile
