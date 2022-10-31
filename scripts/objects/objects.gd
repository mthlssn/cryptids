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
	print("Tem isso ae: ", Global.get_interacoes_maria())
	
	if not interagido and dialogo_resource:
		verificar_status()
	
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
		if "flor" in self.name:
			if not Global.get_onze_horas() and Global.get_players().size() > 1:
				Global.set_onze_horas(true)
				
				var maria_flores = load("res://data/dialogs/pt_BR/maria/maria_flores.tres")
				yield(DialogBox, "dialogo_acabou")
				DialogBox.call_dialog_box(true, maria_flores.msg_queue, maria_flores.nome, maria_flores.imagens)
				
				for node in get_parent().get_children():
					if "flor_branca" in node.name:
						node.dialogo_resource = load("res://data/dialogs/pt_BR/objects/onze_horas_brancas.tres")
					elif "flor_vermelha" in node.name:
						node.dialogo_resource = load("res://data/dialogs/pt_BR/objects/onze_horas_vermelhas.tres")
					elif "flor_amarela" in node.name:
							node.dialogo_resource = load("res://data/dialogs/pt_BR/objects/onze_horas_amarelas.tres")
		elif "girassol" in self.name:
			if Global.get_players().size() > 1 and not Global.get_girassol():
				Global.set_girassol(true)
				var maria_girassol = load("res://data/dialogs/pt_BR/maria/maria_girassol.tres")
				DialogBox.call_dialog_box(true, maria_girassol.msg_queue, maria_girassol.nome, maria_girassol.imagens)
			else:
				DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
		elif self.name == "arvore2":
			var direcoes = Global.get_direcao_players()
			
			if direcoes[direcoes.size()-1] == Vector2(0, 1) and Global.get_players().size() > 1 and not Global.get_interacao_arvore():
				var maria_esconde_esconde = load("res://data/dialogs/pt_BR/maria/maria_esconde_esconde.tres")
				DialogBox.call_dialog_box(true, maria_esconde_esconde.msg_queue, maria_esconde_esconde.nome, maria_esconde_esconde.imagens)
				Global.set_interacoes_maria(Global.get_interacoes_maria() + 1)
				Global.set_interacao_arvore(true)
			else:
				DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
		elif self.name == "arbusto_grande2":
			var combate = load("res://scenes/combate/combate.tscn").instance()
			Global.get_node_demo().add_child(combate)
			combate.chamar_combate(["player", "gamba"])
		elif name == "fogueira":
			if not interagido:
				yield(DialogBox, "dialogo_acabou")
				
			var foto = load("res://scenes/outros/foto.tscn").instance()
			Global.get_node_demo().add_child(foto)
		elif name == "mesa_desenho1":
			var desenho = load("res://scenes/outros/desenho.tscn").instance()
			Global.get_node_demo().add_child(desenho)
			
			desenho.chamar_desenho(1)
			
			get_node("sprite/desenho").hide()
			func_interacao = false
			
		elif name == "cama1":
			var pergunta = load("res://scenes/outros/pergunta.tscn").instance()
			Global.get_node_demo().add_child(pergunta)
			
			pergunta.chamar_pergunta("Deseja dormir?")
			yield(pergunta, "respondido")
			var res = pergunta.resposta
			
			pergunta.queue_free()
			
			if res:
				func_interacao = false
	
	if not interagido:
		interagido = true

func verificar_status():
	var interagidos = Global.get_interagidos()
		
	if interagidos.size() > 0:
		for i in interagidos.size():
			if interagidos[i] == dialogo_resource.nome_dr:
				interagido = true
				break
