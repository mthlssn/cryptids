extends Node2D

export(Resource) var interaction

var _sprite_width_tile = 1 
var _sprite_height_tile = 1 

var type = 2

func interacao():
	if self.name == "maria": 
		if get_node("sprite/animation_player").is_playing():
			get_parent().get_node("maria").ocultar_exclamacao()
		
	if interaction:
		DialogBox.call_dialog_box(true, interaction[0].msg_queue, interaction[0].nome, interaction[0].imagens)

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile
