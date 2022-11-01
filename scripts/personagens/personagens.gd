extends Node2D

export(Resource) var interaction

var _sprite_width_tile = 1 
var _sprite_height_tile = 1 

export var type = 2
export var dr_personagem = true

func interacao():
	if interaction:
		if dr_personagem:
			DialogBox.call_dialog_box(true, interaction.msg_queue, interaction.nome, interaction.imagens)
		else:
			DialogBox.call_dialog_box(false, interaction.msg_queue, null, null)
	
	if self.name == "biscoito":
		match interaction.nome_dr:
			"biscoito_normal":
				var direcao = Global.get_direcao_players()
					
				match direcao[0]:
					Vector2(0,1):
						$sprite.frame = 4
					Vector2(-1, 0):
						$sprite.frame = 10
				
				yield(DialogBox,"dialogo_acabou")
				$sprite.frame = 1
	
	if self.name == "maria": 
		var contar = false
		match interaction.nome_dr:
			"maria_olhos":
				contar = true
			"maria_papai":
				contar = true
			"maria_tio_jorge":
				contar = true
			"maria_pegar_pratos":
				var direcao = Global.get_direcao_players()
					
				match direcao[0]:
					Vector2(0,-1):
						$sprite.frame = 1
					Vector2(1, 0):
						$sprite.frame = 7
				
				yield(DialogBox,"dialogo_acabou")
				$sprite.frame = 10
				dr_personagem = false
				get_parent().get_parent().pegar_pratos = true
				interaction = load("res://data/dialogs/pt_BR/maria/maria_concentrada.tres")
			"maria_biscoitos":
				var direcao = Global.get_direcao_players()
					
				match direcao[0]:
					Vector2(0,-1):
						$sprite.frame = 1
					Vector2(1, 0):
						$sprite.frame = 7
				
				yield(DialogBox,"dialogo_acabou")
				$sprite.frame = 10
		
		if contar:
			Global.set_interacoes_maria(Global.get_interacoes_maria() + 1)
		
		if get_node("sprite/animation_player").is_playing():
			get_parent().get_node("maria").ocultar_exclamacao()
			interaction = load("res://data/dialogs/pt_BR/maria/maria_normal.tres")

func get_sprite_width_tile():
	return _sprite_width_tile
	
func get_sprite_height_tile():
	return _sprite_height_tile

func _on_sprite_frame_changed():
	if $sprite.frame >= 0 and 5 >= $sprite.frame:
		$sprite/sombra1.hide()
		$sprite/sombra2.show()
		
	else:
		$sprite/sombra1.show()
		$sprite/sombra2.hide()
		
		if $sprite.frame >= 6 and 8 >= $sprite.frame:
			$sprite/sombra1.position = Vector2(1,9)
		else:
			$sprite/sombra1.position = Vector2(-1,9)
