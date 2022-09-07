extends CanvasLayer

onready var dialog := $dialog
onready var text := $dialog/text
onready var timer := $dialog/timer
onready var timer2 := $dialog/timer_2
onready var setinha := $dialog/setinha

onready var dialog_box_c_per = preload("res://assets/dialog_box/dialog_box_personagem.png")
onready var dialog_box_s_per = preload("res://assets/dialog_box/dialog_box_sem_personagem.png")

var msg_queue : Array = []
var tecla = "nada"

var max_length_text = 0
var posicao_text = 0

var node_pause
var pausar = false

func _ready():
	if msg_queue.size() == 0:
		hide()

func call_dialog_box(mensagem, tem_foto):
	text.bbcode_text = ""
	node_pause = Global.get_node_demo_cena()
	tecla = "ui_accept"
	msg_queue = mensagem
	setinha.hide()
	
	max_length_text = msg_queue.size()
	posicao_text = -1
	
	if tem_foto:
		dialog.texture = dialog_box_c_per
		dialog.region_rect = Rect2(0, 0, 440, 80)
		
		text.margin_bottom = 64
		text.margin_left = 104
		text.margin_right = 448
		text.margin_top = 24
	else:
		dialog.texture = dialog_box_s_per
		dialog.region_rect = Rect2(0, 0, 439, 71) 
		
		text.margin_bottom = 64
		text.margin_left = 16
		text.margin_right = 448
		text.margin_top = 26
	
	if not visible:
		show()
	
	timer2.start()

func _input(event):
	if event.is_action_pressed(tecla):
		show_message()
	
	if event.is_action_pressed("esc") && visible == true:
		timer.stop()
		posicao_text = max_length_text - 1
		pausar = true
		show_message()

func show_message() -> void:
	setinha.hide()
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		setinha.show()
		return

	if max_length_text <= (posicao_text+1):
		tecla = "nada"
		msg_queue = []
		
		hide()
		
		node_pause.get_tree().paused = false
		
		if pausar:
			pausar = false
			Pause.pause()
		
		return	
	
	if node_pause.get_tree().paused == false:
		node_pause.get_tree().paused = true

	posicao_text += 1
	var _msg : String = msg_queue[posicao_text]
	
	text.visible_characters = 0
	text.bbcode_text = _msg
	
	timer.start()

func _on_timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		timer.stop()
		setinha.show()
	text.visible_characters += 1


func _on_timer_2_timeout():
	show_message()
