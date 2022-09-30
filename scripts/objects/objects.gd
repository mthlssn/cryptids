extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT, NPC, FOLLOW}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var interaction

var interagido = false

func _ready():
	if interaction :
		var interagidos = Global.get_interagidos()

		if interagidos.size() > 0:
			for i in interagidos.size():
				if interagidos[i] == interaction.nome:
					interagido = true
					break

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if interaction:
		if interagido:
			DialogBox.call_dialog_box(false, interaction.msg_queue1, null, null)
		else:
			DialogBox.call_dialog_box(false, interaction.msg_queue, null, null)
			interagido = true
			Global.set_interagidos(interaction.nome)

