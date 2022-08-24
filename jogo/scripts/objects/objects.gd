extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export var texto = " "

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	var posicao = self.position

	posicao.x = (posicao.x - 16)+ ((_sprite_width_tile * 32)/2)
	posicao.y = posicao.y + 16
	
	var node_pai = get_parent().get_parent()
	
	var next_level_resource = load("res://scenes/label.tscn")
	var next_level = next_level_resource.instance()
	node_pai.add_child(next_level)
	
	for i in node_pai.get_children():
		if i.name == "label":
			i.mostrar_texto(texto, posicao)
			
	#GlobalCanvasLayer.funciona2()
	#Dialog.funciona()
	
	var next_level_resource2 = load("res://scenes/dialog/dialog.tscn")
	var next_level2 = next_level_resource2.instance()
	node_pai.add_child(next_level2)
