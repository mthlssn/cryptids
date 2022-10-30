extends Node2D

enum CELL_TYPES{EMPTY = -1,  OBSTACLE, AREA, PLAYER, OBJECT, NPC, FOLLOW}
export(CELL_TYPES) var type = CELL_TYPES.AREA

var _sprite_width_tile = 1 
var _sprite_height_tile = 1 

export(bool) var dg_interacao = true
export(bool) var func_interacao = false

export(Resource) var dialogo_resource
export(bool) var dr_personagem = false

var interagido = false

func _ready():
	_sprite_width_tile = ($cor.margin_right + 16) / 32
	_sprite_height_tile = ($cor.margin_bottom + 16) / 32
	
	if not self.visible:
		position = Vector2(-480, -288)
	
	if self.get_parent().name != "area":
		if not get_node("../area").visible:
			$cor.hide()
	
	if dialogo_resource:
		verificar_status()

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func interacao():
	if not interagido:
		verificar_status()
	
	match self.name:
		"arvore2":
			var direcoes = Global.get_direcao_players()
			
			if direcoes[direcoes.size()-1] == Vector2(0, 1) and Global.get_players().size() > 1:
				dialogo_resource = load("res://data/dialogs/pt_BR/maria/maria_esconde_esconde.tres")
				DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
				return
			else:
				dialogo_resource = load("res://data/dialogs/pt_BR/objects/arvore.tres")
	
	if dg_interacao:
		if interagido:
			if not dr_personagem:
				DialogBox.call_dialog_box(false, dialogo_resource.msg_queue1, null, null)
		else:
			if dr_personagem:
				DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
			else:
				DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
				
			var temp = Global.get_interagidos()
			temp.resize(temp.size() + 1)
			temp[temp.size() - 1] = dialogo_resource.nome_dr
			Global.set_interagidos(temp)
	
	if func_interacao:
		if not interagido:
			yield(DialogBox, "dialogo_acabou")
			
		match self.name:
			"arbusto_grande2":
				var combate = load("res://scenes/combate/combate.tscn").instance()
				Global.get_node_demo().add_child(combate)
				combate.chamar_combate(["player", "gamba"])
			"fogueira1":
				var foto = load("res://scenes/outros/foto.tscn").instance()
				Global.get_node_demo().add_child(foto)
	
	if not interagido:
		interagido = true

func verificar_status():
	var interagidos = Global.get_interagidos()
		
	if interagidos.size() > 0:
		for i in interagidos.size():
			if interagidos[i] == dialogo_resource.nome_dr:
				interagido = true
				break
