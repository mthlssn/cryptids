extends NinePatchRect

var combate

var _msg 
var cont = 0

var voltar = false

var chamar_animacao_acertado = false
var animacao = ""

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
	combate = get_parent()

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
		if texto.visible_characters == texto.bbcode_text.length():
			return
		
		if texto.visible_characters > 8:
			texto.visible_characters = texto.bbcode_text.length()
		
		return
	
	if "###" in _msg[cont]:
		chamar_animacao_acertado = true
		animacao = _msg[cont]
		cont += 1
	
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
	if chamar_animacao_acertado:
		var personagem
		var tipo_animacao
		
		if "player" in animacao:
			personagem = "player"
		elif "maria" in animacao:
			personagem = "maria"
		elif "biscoito" in animacao:
			personagem = "biscoito"
		elif "inimigo" in animacao:
			personagem = "inimigo"
		elif "todos_aliados" in animacao:
			personagem = "todos_aliados"
		
		if "dano" in animacao:
			tipo_animacao = "dano"
		elif "debuff" in animacao:
			tipo_animacao = "debuff"
		elif "cura" in animacao:
			tipo_animacao = "cura"
		
		var animation = combate.get_node("animation_player")
		animation.play(tipo_animacao + "_" + personagem)
		chamar_animacao_acertado = false
		
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
