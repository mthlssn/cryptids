extends CanvasLayer

onready var text := $dialog/text
onready var timer := $dialog/timer
onready var timer2 := $dialog/timer_2

var msg_queue : Array = []
var tecla = "nada"

var max_length_text = 0
var posicao_text = 0

var node_pause
var pausar = false

func _ready():
	if msg_queue.size() == 0:
		hide()

func add_mensagem(mensagem):
	text.bbcode_text = ""
	node_pause = Global.get_node_demo_cena()
	tecla = "ui_accept"
	msg_queue = mensagem
	
	max_length_text = msg_queue.size()
	posicao_text = -1
	
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
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()		

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
	text.visible_characters += 1


func _on_timer_2_timeout():
	show_message()
