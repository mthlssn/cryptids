extends CanvasLayer

var resposta : bool

signal respondido

func chamar_pergunta(label):
	Global.set_mover(false)
	Global.set_pausar(false)
	
	$center/v_container/label.text = label
	$center/v_container/h_container/nao.grab_focus()
	
	yield(self, "respondido")
	hide()
	Global.set_mover(true)
	Global.set_pausar(true)

func _on_sim_pressed():
	resposta = true
	emit_signal("respondido")

func _on_nao_pressed():
	resposta = false
	emit_signal("respondido")
