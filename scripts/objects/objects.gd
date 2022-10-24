extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, AREA, PLAYER, OBJECT, NPC, FOLLOW}
export(CELL_TYPES) var type = CELL_TYPES.AREA

var _sprite_width_tile = 1 
var _sprite_height_tile = 1 

export(Resource) var dialogo_resource

var interagido = false

func _ready():
	if self.visible:
		_sprite_width_tile = ($cor.margin_right + 16) / 32
		_sprite_height_tile = ($cor.margin_bottom + 16) / 32
	else:
		position = Vector2(-480, -288)
	
	if self.get_parent().name != "area":
		if not get_node("../area").visible:
			$cor.hide()

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	verificar_status()
	if dialogo_resource:
		if interagido:
			DialogBox.call_dialog_box(false, dialogo_resource.msg_queue1, null, null)
		else:
			DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
			interagido = true
			
			var temp = Global.get_interagidos()
			temp.resize(temp.size() + 1)
			temp[temp.size() - 1] = dialogo_resource.nome_dr
			Global.set_interagidos(temp)

func verificar_status():
	var interagidos = Global.get_interagidos()
		
	if interagidos.size() > 0:
		for i in interagidos.size():
				
			if interagidos[i] == dialogo_resource.nome_dr:
				interagido = true
				break
