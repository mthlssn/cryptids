extends Control

onready var sprite_setinha := $personagem/setinha
onready var animacao_setinha := $personagem/animation_player

func _ready():
	sprite_setinha.hide()
	animacao_setinha.stop()

func _on_botao_focus_exited():
	sprite_setinha.hide()
	animacao_setinha.stop()

func _on_botao_focus_entered():
	sprite_setinha.show()
	animacao_setinha.play("setinha")
