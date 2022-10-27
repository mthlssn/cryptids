extends Control

var combate

signal acao_apertada

func chamar_acoes():
	combate = get_parent()
	show()

func _on_botao_pressed(extra_arg_0):
	combate.set_acao_apertada(extra_arg_0)
	emit_signal("acao_apertada")
	hide()

func _on_botao_focus_entered(extra_arg_0):
	combate.set_acao_selecionada(extra_arg_0)
	match extra_arg_0:
		"agir":
			$agir/icon.texture = load("res://assets/combate/agir.png")
		"pular":
			$pular/icon.texture = load("res://assets/combate/pular.png")
		"itens":
			$itens/icon.texture = load("res://assets/combate/itens.png")
		"fugir":
			$fugir/icon.texture = load("res://assets/combate/fugir.png")

func _on_botao_focus_exited(extra_arg_0):
	match extra_arg_0:
		"agir":
			$agir/icon.texture = load("res://assets/combate/agir_s_cor.png")
		"pular":
			$pular/icon.texture = load("res://assets/combate/pular_s_cor.png")
		"itens":
			$itens/icon.texture = load("res://assets/combate/itens_s_cor.png")
		"fugir":
			$fugir/icon.texture = load("res://assets/combate/fugir_s_cor.png")
