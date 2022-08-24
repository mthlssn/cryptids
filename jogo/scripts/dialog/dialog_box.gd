extends NinePatchRect

onready var text := $text
onready var timer := $timer

var msg_queue : Array = [
	"Teste teste opa leo minha namo, n termina cmg",
	"Foi mudou"
]

func funciona():
	
	if not visible:
		show()

func _input(event):
	if event is InputEventKey and event.is_action_pressed("key_e"):
		show_message()
		
func show_message() -> void:
	if not timer.is_stopped():
		text.visible_characters = text.bbcode_text.length()
		print(self, " aqui")
		return
	
	print(self, " aqui2")
	if msg_queue.size() == 0:
		hide()
		return
	
	var _msg : String = msg_queue.pop_front()
	
	text.visible_characters = 0
	text.bbcode_text = _msg
	
	timer.start()

func _on_timer_timeout():
	if text.visible_characters == text.bbcode_text.length():
		timer.stop()
	text.visible_characters += 1
