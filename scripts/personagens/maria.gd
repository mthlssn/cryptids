extends "personagens.gd"

onready var exclamacao_sprite := $sprite/exclamacao
onready var exclamacao_animation := $sprite/animation_player

func mostrar_exclamacao():
	exclamacao_sprite.show()
	exclamacao_animation.play("exclamacao")
	
func ocultar_exclamacao():
	exclamacao_sprite.hide()
	exclamacao_animation.stop()
