extends NinePatchRect

var combate = get_parent()

var _msg 
var cont = 0

var voltar = false

signal dialogo_fechado

onready var texto := $text
onready var timer := $timer
onready var timer2 := $timer2
onready var setinha_xis := $setinha_xis
onready var node_sprite_setinha_xis := $setinha_xis/sprite
onready var animacao_setinha_xis := $setinha_xis/animation_player

onready var sprite_setinha = preload("res://assets/dialog_box/setinha.png")
onready var sprite_xis = preload("res://assets/dialog_box/xis.png")

func _ready():
	node_sprite_setinha_xis.texture = null
	texto.bbcode_text = ""

func chamar_dialogo(mensagem):
	show()
	_msg = mensagem
	setinha_xis.grab_focus()
	timer2.start()
	voltar = false

func show_message() -> void:
	setinha_xis.grab_focus()
	node_sprite_setinha_xis.texture = null
	animacao_setinha_xis.stop()
	
	if not timer.is_stopped():
		texto.visible_characters = texto.bbcode_text.length()
		return
	
	texto.visible_characters = 0
	texto.bbcode_text = _msg[cont]
	
	timer.start()

func _on_setinha_xis_pressed():
	if voltar:
		emit_signal("dialogo_fechado")
		texto.bbcode_text = ""
		node_sprite_setinha_xis.texture = null
		cont = 0
	else:
		show_message()

func _on_timer_timeout():
	if texto.visible_characters == texto.bbcode_text.length():
		timer.stop()
		cont += 1
		
		if cont == _msg.size():
			voltar = true
		
		node_sprite_setinha_xis.texture = sprite_setinha
		animacao_setinha_xis.play("setinha")
		
	texto.visible_characters += 1

func _on_timer2_timeout():
	show_message()
