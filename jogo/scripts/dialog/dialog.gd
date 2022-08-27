extends CanvasLayer

onready var text := $dialog/text
onready var timer := $dialog/timer

var msg_queue : Array = []
var tecla = "nada"

var max_length_text = 0
var posicao_text = 0

var node_pause

func _ready():
	if msg_queue.size() == 0:
		hide()
		
	text.bbcode_text = ""

func add_mensagem(mensagem, node_pai):
	node_pause = node_pai
	tecla = "ui_accept"
	msg_queue = mensagem
	
	max_length_text = msg_queue.size()
	posicao_text = -1
	
	if not visible:
		show()
	
	show_message()

func _input(event):
	if event.is_action_pressed(tecla):
		show_message()

func show_message() -> void:
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()		
		return

	if max_length_text <= (posicao_text+1):
		tecla = "nada"
		hide()
		
		if node_pause.get_tree().paused == true:
			node_pause.get_tree().paused = false
			
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
