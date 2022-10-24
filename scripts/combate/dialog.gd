extends NinePatchRect

var combate = get_parent()

var _msg 
var voltar = false

signal dialogo_fechado

onready var texto := $text
onready var timer := $timer
onready var timer2 := $timer2
onready var xis := $xis
onready var node_sprite_xis := $xis/sprite
onready var animacao_xis := $xis/animation_player

onready var sprite_xis = preload("res://assets/dialog_box/xis.png")

func _ready():
	node_sprite_xis.texture = null
	texto.bbcode_text = ""

func chamar_dialogo(mensagem):
	show()
	_msg = mensagem
	xis.grab_focus()
	timer2.start()
	voltar = false

func show_message() -> void:
	xis.grab_focus()
	node_sprite_xis.texture = null
	animacao_xis.stop()
	
	if not timer.is_stopped():
		texto.visible_characters = texto.bbcode_text.length()
		return
		
	if texto.visible_characters == texto.bbcode_text.length():
		texto.bbcode_text = ""
		return
	
	texto.visible_characters = 0
	texto.bbcode_text = _msg
	
	timer.start()

func _on_xis_pressed():
	if voltar:
		emit_signal("dialogo_fechado")
		texto.bbcode_text = ""
		node_sprite_xis.texture = null
		#hide()
	else:
		show_message()

func _on_timer_timeout():
	if texto.visible_characters == texto.bbcode_text.length():
		timer.stop()
		
		node_sprite_xis.texture = sprite_xis
		animacao_xis.play("xis")
		
		voltar = true
		
	texto.visible_characters += 1

func _on_timer2_timeout():
	show_message()
