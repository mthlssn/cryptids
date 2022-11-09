extends CanvasLayer

func chamar_mapa():
	
	Global.set_mover(false)
	Global.set_pausar(false)
	
	show()
	
	$animation_player.play("abri_mapa")
	
	yield($animation_player, "animation_finished")
	
	if DialogBox.visible:
		yield(DialogBox, "dialogo_acabou")
		
	$fechar.grab_focus()

func _on_fechar_pressed():
	$animation_player.play("fechar_mapa")
	
	yield($animation_player, "animation_finished")
	Global.set_mover(true)
	Global.set_pausar(true)

	queue_free()
