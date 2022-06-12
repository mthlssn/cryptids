extends KinematicBody2D

enum CELL_TYPES{EMPYT = -1,  OBSTACLE, PLAYER, OBJECT }
export(CELL_TYPES) var type = CELL_TYPES.OBSTACLE

export var _sprite_width_tile = 1 

var sla : Array

func get_sprite_width_tile():
	return _sprite_width_tile

func _ready():
	sla = get_parent().get_children()
	
func _process(_delta):
	position = sla[1].get_ultima_posicao()

