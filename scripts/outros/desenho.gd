extends CanvasLayer

onready var desenho1 = preload("res://assets/outros/desenho1.png")
onready var desenho2 = preload("res://assets/outros/desenho2.png")

signal desenho_fechado

func chamar_desenho(desenho):
	
	Global.set_mover(false)
	Global.set_pausar(false)
	
	show()
	
	$animation_player.play("abri_desenho")
	
	match desenho:
		1:
			$desenho.texture = desenho1
			
		2:
			$desenho.texture = desenho2
	
	yield($animation_player, "animation_finished")
	$fechar.grab_focus()

func _on_fechar_pressed():
	$animation_player.play("fechar_desenho")
	
	yield($animation_player, "animation_finished")
	Global.set_mover(true)
	Global.set_pausar(true)
	
	emit_signal("desenho_fechado")
