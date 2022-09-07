extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, PORTAL, PLAYER, OBJECT}
export(CELL_TYPES) var type = CELL_TYPES.PORTAL

export var nome : String
export(String, FILE) var path_images 

export var _sprite_width_tile = 1 
export var _sprite_height_tile = 1 

export(Resource) var interaction
var msg_queue 

var interagido = false

var copia : Array

func _ready():
	if interaction :
		var interagidos = Global.get_interagidos()

		if interagidos.size() > 0:
			for i in interagidos.size():
				if interagidos[i] == interaction.nome:
					interagido = true
					break
		
		msg_queue = interaction.msg_queue
		var mostrar_depois = interaction.mostrar_depois
		var size = mostrar_depois.size()
		
		if size <= 1:
			copia.resize(size+1)
		else:
			copia.resize(size)
		
		if !type == CELL_TYPES.PORTAL:
			for i in size:
				copia[i] = msg_queue[mostrar_depois[i]]
		
		if size <= 1:
			copia.pop_back()

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if interaction:
		if interagido and copia.size() > 0:
			DialogBox.call_dialog_box(copia, false, null, null)
		else:
			DialogBox.call_dialog_box(msg_queue, false, null, null)
			interagido = true
			Global.set_interagidos(interaction.nome)
	else:
		DialogBox.call_dialog_box(["Ainda não tem interação", "Desculpe :)"], true, "Thalisson", null)

