extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, AREA, PLAYER, OBJECT, NPC, FOLLOW}
export(CELL_TYPES) var type = CELL_TYPES.AREA

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var dialogo_resource

var interagido = false

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	verificar_status()
	if dialogo_resource:
		if self.name == "arbusto5":
			var sla = load("res://scenes/combate/combate.tscn").instance()
			get_node("/root").add_child(sla)
			sla.chamar_combate(["player", "sarue"])
		elif interagido:
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
