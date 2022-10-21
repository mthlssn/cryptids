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

var tecla = "nada"

var pausar = false

var cont = 0
var cont_msg_queue = 0

var node_input_box

func _ready():
	if _msg_queue.size() == 0:
		hide()

func call_dialog_box(personagem, mensagem, nomes_perso, imagens_perso):
	_nomes = nomes_perso
	_msg_queue = mensagem
	_imagens = imagens_perso
	
	text.bbcode_text = ""
	tecla = "ui_accept"
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
		
	animacao.play("open")

func _input(event):
	if event.is_action_pressed(tecla):
		if mudar_texto():
			return
		
		if _nomes != null:
			mudar_nome()
		
		if _imagens != null:
			mudar_imagem()
		
		show_message()
	
	if event.is_action_pressed("ui_cancel") && visible == true:
		if not node_input_box:
			timer.stop()
			cont_msg_queue = _msg_queue.size()
			pausar = true
			show_message()

func show_message() -> void:
	sprite_set_ou_xis.texture = null
	animacao_set_ou_xis.stop()
	
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		return

	if _msg_queue.size() <= cont_msg_queue:
		tecla = "nada"
		_msg_queue = []
		text.bbcode_text = ""
		cont = 0
		cont_msg_queue = 0
		node_input_box = null
		
		Global.set_mover(true)
		
		if pausar:
			hide()
			pausar = false
			Menu.pause()
		else:
			animacao.play("close")
			yield(animacao, "animation_finished")
	
		return
	
	text.visible_characters = 0
	text.bbcode_text = _msg
	
	timer.start()

func _on_timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		cont += 1
		cont_msg_queue += 1
		
		timer.stop()
		
		if cont == _msg_queue.size():
			sprite_set_ou_xis.texture = sprite_xis
			animacao_set_ou_xis.play("xis")
		else:
			sprite_set_ou_xis.texture = sprite_setinha
			animacao_set_ou_xis.play("setinha")
			
		#set_ou_xis.show()
		
	text.visible_characters += 1

func _on_timer_2_timeout():
	show_message()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		label_name.show()
		personagem_foto.show()
		timer2.start()

func mudar_imagem():
	if _imagens.size() > cont:
		personagem_foto.texture = load(get_path_imagem(_imagens[cont]))

func mudar_nome():
	if _nomes.size() > cont:
		if _nomes[cont] == "{nome_player}":
			label_name.text = Global.get_nome_player()
		else:
			label_name.text = _nomes[cont]

func mudar_texto():
	if _msg_queue.size() > cont_msg_queue:
		if "func" in _msg_queue[cont_msg_queue]:
			match _msg_queue[cont_msg_queue]:
				"func_chamar_input()":
					Global.set_pausar(false)
					chamar_input()
			cont_msg_queue += 1
			return true
		
		if "{nome_player}" in _msg_queue[cont_msg_queue]:
			_msg = _msg_queue[cont_msg_queue].format({"nome_player": Global.get_nome_player()})
		else:
			_msg = _msg_queue[cont_msg_queue]

func get_path_imagem(imagem):
	match imagem:
		"player_normal":
			return "res://assets/dialog_box/personagens/player/normal.png"
		"maria_feliz":
			return "res://assets/dialog_box/personagens/maria/feliz.png"
		"maria_normal":
			return "res://assets/dialog_box/personagens/maria/normal.png"
		"maria_pensante":
			return "res://assets/dialog_box/personagens/maria/pensante.png"
		"maria_triste":
			return "res://assets/dialog_box/personagens/maria/triste.png"
		"mel_normal":
			return "res://assets/dialog_box/personagens/mel/normal.png"

func chamar_input():
	tecla = "nada"
	var cena = load("res://scenes/dialog_box/input_box.tscn")
	node_input_box = cena.instance()
	add_child(node_input_box)
