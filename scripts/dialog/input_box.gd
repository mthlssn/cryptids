extends CanvasLayer

onready var input := $input
var old_text = ""

func _ready():
	input.grab_focus()

func _on_input_text_entered(new_text):
	if new_text.length() >= 3: 
		Global.set_nome_player(new_text)
		
		get_parent().tecla = "ui_accept"
		
		Global.set_pausar(true)
		
		queue_free()

func _on_input_text_changed(new_text):
	if " " in  new_text:
		input.text = old_text
		input.caret_position = old_text.length()
	else:
		old_text = new_text