extends CanvasLayer

signal jornal_fechado

func chamar_jornal():
	
	Global.set_mover(false)
	Global.set_pausar(false)
	
	show()
	
	$animation_player.play("abri_jornal")
	
	yield($animation_player, "animation_finished")
	$fechar.grab_focus()

func _on_fechar_pressed():
	$animation_player.play("fechar_jornal")
	
	yield($animation_player, "animation_finished")
	Global.set_mover(true)
	Global.set_pausar(true)
	
	emit_signal("jornal_fechado")
	queue_free()
