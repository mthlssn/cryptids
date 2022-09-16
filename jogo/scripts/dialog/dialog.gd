extends CanvasLayer

onready var dialog := $dialog
onready var text := $dialog/text
onready var timer := $dialog/timer
onready var timer2 := $dialog/timer_2
onready var setinha := $dialog/setinha
onready var animacao_setinha := $dialog/setinha/animation_player
onready var label_name := $dialog/name
onready var personagem_foto := $dialog/personagem
onready var animacao := $animation_player

onready var dialog_box_c_per = preload("res://assets/dialog_box/dialog_box_personagem.png")
onready var dialog_box_s_per = preload("res://assets/dialog_box/dialog_box_sem_personagem.png")

var msg_queue : Array = []
var tecla = "nada"

var max_length_text = 0
var posicao_text = 0

var node_pause
var pausar = false

var cont = 0

var imagens
var nomes

func _ready():
	if msg_queue.size() == 0:
		hide()

func call_dialog_box(personagem, mensagem, nomes_perso, imagens_perso):
	node_pause = Global.get_node_demo_cena()
	node_pause.get_tree().paused = true
	
	nomes = nomes_perso
	msg_queue = mensagem
	imagens = imagens_perso
	
	text.bbcode_text = ""
	tecla = "ui_accept"
	label_name.text = ""
	personagem_foto.texture = null
	
	setinha.hide()
	
	max_length_text = msg_queue.size()
	posicao_text = -1
	
	if personagem:
		dialog.texture = dialog_box_c_per
		
		text.margin_bottom = 74
		text.margin_left = 106
		text.margin_right = 459
		text.margin_top = 18
	else:
		dialog.texture = dialog_box_s_per
		
		text.margin_bottom = 74
		text.margin_left = 22
		text.margin_right = 459
		text.margin_top = 18
	
	if imagens_perso != null:
		mudar_imagem()
		
	if nomes != null:
		mudar_nome()
		
	if not visible:
		animacao.play("open")

func _input(event):
	if event.is_action_pressed(tecla):
		if imagens != null:
			mudar_imagem()
			
		if nomes != null:
			mudar_nome()
			
		show_message()
	
	if event.is_action_pressed("esc") && visible == true:
		timer.stop()
		posicao_text = max_length_text - 1
		pausar = true
		show_message()

func show_message() -> void:
	setinha.hide()
	animacao_setinha.stop()
	
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		return

	if max_length_text <= (posicao_text+1):
		tecla = "nada"
		msg_queue = []
		text.bbcode_text = ""
		cont = 0
		
		node_pause.get_tree().paused = false
		
		if pausar:
			hide()
			pausar = false
			Pause.pause()
		else:
			animacao.play("close")
			yield(animacao, "animation_finished")
		
		return
	
	posicao_text += 1
	var _msg : String = msg_queue[posicao_text]
	
	text.visible_characters = 0
	text.bbcode_text = _msg
	
	timer.start()

func mudar_imagem():
	if imagens.size() > cont:
		personagem_foto.texture = load(imagens[cont])

func mudar_nome():
	if nomes.size() > cont:
		label_name.text = nomes[cont]

func _on_timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		cont += 1
		
		timer.stop()
		
		setinha.show()
		animacao_setinha.play("setinha")
	text.visible_characters += 1

func _on_timer_2_timeout():
	show_message()

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "open":
		label_name.show()
		personagem_foto.show()
		timer2.start()
