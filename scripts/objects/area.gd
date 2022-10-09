extends "objects.gd"

export var function : String = "" 

export var colisao = true

export var apagar = false

func _ready():
	var cor = get_children()
	_sprite_width_tile = (cor[0].margin_right + 16) / 32
	_sprite_height_tile = (cor[0].margin_bottom + 16) / 32
