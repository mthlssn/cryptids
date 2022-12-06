extends CanvasLayer

onready var dialog := $dialog
onready var text := $dialog/text
onready var timer := $dialog/timer
onready var timer2 := $dialog/timer_2
onready var set_ou_xis := $dialog/set_ou_xis
onready var sprite_set_ou_xis := $dialog/set_ou_xis/sprite
onready var animacao_set_ou_xis := $dialog/set_ou_xis/animation_player
onready var label_name := $dialog/name
onready var personagem_foto := $dialog/personagem
onready var animacao := $animation_player

onready var dialog_box_c_per = preload("res://assets/dialog_box/dialog_box_personagem.png")
onready var dialog_box_s_per = preload("res://assets/dialog_box/dialog_box_sem_personagem.png")

onready var sprite_setinha = preload("res://assets/dialog_box/setinha.png")
onready var sprite_xis = preload("res://assets/dialog_box/xis.png")

var _msg_queue : Array = []
var _imagens
var _nomes
var _msg 

var _tecla = "nada"

var _pausar = false

var _cont = 0
var _cont_msg_queue = 0

var _node_cutscene

var _node_input_box

var pular = false

signal dialogo_acabou

func _ready():
	if _msg_queue.size() == 0:
		hide()

func call_dialog_box(personagem, mensagem, nomes_perso, imagens_perso):
	_nomes = nomes_perso
	_msg_queue = mensagem
	_imagens = imagens_perso
	
	text.bbcode_text = ""
	_tecla = "ui_accept"
	label_name.text = ""
	personagem_foto.texture = null
	
	sprite_set_ou_xis.texture = null
	Global.set_mover(false)
	
	if personagem:
		dialog.texture = dialog_box_c_per
		
		text.margin_bottom = 74
		text.margin_left = 106
		text.margin_right = 459
		text.margin_top = 19
	else:
		dialog.texture = dialog_box_s_per
		
		text.margin_bottom = 74
		text.margin_left = 22
		text.margin_right = 459
		text.margin_top = 19
		
	mudar_texto()
		
	if _nomes != null:
		mudar_nome()
	
	if imagens_perso != null:
		mudar_imagem()
		
	if _msg_queue.size() != 0:
		animacao.play("open")
	else:
		Global.set_mover(true)
		Global.set_pausar(true)

func _input(event):
	if event.is_action_pressed(_tecla):
		if mudar_texto():
			return
		
		if _nomes != null:
			mudar_nome()
		
		if _imagens != null:
			mudar_imagem()
		
		show_message()
	
	if event.is_action_pressed("ui_cancel") and visible and pular:
		if not _node_input_box:
			timer.stop()
			_cont_msg_queue = _msg_queue.size()
			_pausar = true
			show_message()

func show_message() -> void:
	sprite_set_ou_xis.texture = null
	animacao_set_ou_xis.stop()
	
	if not timer.is_stopped():
		if text.visible_characters == text.bbcode_text.length():
			return
		
		if text.visible_characters > 8:
			text.visible_characters = text.bbcode_text.length()
		
		return
	
	if _node_cutscene:
		match _node_cutscene.name:
			"cutscene_maria":
				_node_cutscene.iniciou()
			"cutscene_quarto1":
				_node_cutscene.iniciou()
	
	if _msg_queue.size() <= _cont_msg_queue:
		pular = false
		_tecla = "nada"
		_msg_queue = []
		text.bbcode_text = ""
		_cont = 0
		_cont_msg_queue = 0
		_node_input_box = null
		_node_cutscene = null
		
		if not _node_cutscene:
			Global.set_mover(true)
		
		if _pausar:
			hide()
			_pausar = false
			Menu.pause()
		else:
			animacao.play("close")
			yield(animacao, "animation_finished")
			
			emit_signal("dialogo_acabou")
		
		return
	
	text.visible_characters = 0
	text.bbcode_text = _msg
	
	timer.start()
	pular = true

func _on_timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		_cont += 1
		_cont_msg_queue += 1
		
		timer.stop()
		
		if _cont == _msg_queue.size():
			sprite_set_ou_xis.texture = sprite_xis
			animacao_set_ou_xis.play("xis")
		else:
			sprite_set_ou_xis.texture = sprite_setinha
			animacao_set_ou_xis.play("setinha")
	
	text.visible_characters += 1

func _on_timer_2_timeout():
	show_message()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		label_name.show()
		personagem_foto.show()
		timer2.start()

func mudar_imagem():
	if _imagens.size() > _cont:
		personagem_foto.texture = load(get_path_imagem(_imagens[_cont]))

func mudar_nome():
	if _nomes.size() > _cont:
		if _nomes[_cont] == "{nome_player}":
			label_name.text = Global.get_nome_player()
		else:
			label_name.text = _nomes[_cont]

func mudar_texto():
	if _msg_queue.size() > _cont_msg_queue:
		if "func" in _msg_queue[_cont_msg_queue]:
			match _msg_queue[_cont_msg_queue]:
				"func_chamar_input()":
					Global.set_pausar(false)
					chamar_input()
				"func_chamar_aprendi_ler()":
					_msg = "Aprendeu LEITURA."
					
					dialog.texture = dialog_box_s_per
					
					text.margin_bottom = 74
					text.margin_left = 22
					text.margin_right = 459
					text.margin_top = 19
					
					_nomes = null
					_imagens = null
					
					label_name.text = ""
					personagem_foto.texture = null
					
					return false
			_cont_msg_queue += 1
			return true
		
		if "{nome_player}" in _msg_queue[_cont_msg_queue]:
			_msg = _msg_queue[_cont_msg_queue].format({"nome_player": Global.get_nome_player()})
		else:
			_msg = _msg_queue[_cont_msg_queue]

func get_path_imagem(imagem):
	match imagem:
		"player_normal":
			return "res://assets/personagens/player/normal.png"
		"maria_feliz":
			return "res://assets/personagens/maria/feliz.png"
		"maria_normal":
			return "res://assets/personagens/maria/normal.png"
		"maria_pensante":
			return "res://assets/personagens/maria/pensante.png"
		"maria_triste":
			return "res://assets/personagens/maria/triste.png"
		"biscoito_normal":
			return "res://assets/personagens/biscoito/normal.png"

func chamar_input():
	_tecla = "nada"
	var cena = load("res://scenes/dialog_box/input_box.tscn")
	_node_input_box = cena.instance()
	add_child(_node_input_box)

#------- node_cutscene:
func set_node_cutscene(node_cutscene):
	_node_cutscene = node_cutscene

#------- tecla:
func set_tecla(tecla):
	_tecla = tecla
