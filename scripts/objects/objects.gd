extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, AREA, PLAYER, OBJECT, NPC, FOLLOW}
export(CELL_TYPES) var type = CELL_TYPES.AREA

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var dialogo_resource

export var function : String = "" 

export var apagar = false

var interagido = false

func _ready():
	if dialogo_resource :
		var interagidos = Global.get_interagidos()
		
		if interagidos.size() > 0:
			for i in interagidos.size():
				print(interagidos[i], " ", dialogo_resource.nome_dr)
				if interagidos[i] == dialogo_resource.nome_dr:
					interagido = true
					break
	
	if get_parent().name == "area":
		var cor = get_children()
		_sprite_width_tile = (cor[0].margin_right + 16) / 32
		_sprite_height_tile = (cor[0].margin_bottom + 16) / 32

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if dialogo_resource:
		if interagido:
			DialogBox.call_dialog_box(false, dialogo_resource.msg_queue1, null, null)
		else:
			DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
			interagido = true
			Global.set_interagidos(dialogo_resource.nome_dr)
