extends Control

func _ready():
	Global.set_valores_iniciais()
	$botoes/novo_jogo_botao.grab_focus()
	DataPlayer.load_data(1)

func _on_novo_jogo_botao_pressed():
	Eventos.chamar_evento()

func _on_sair_botao_pressed():
	get_tree().quit()

func _on_configuracao_botao_pressed():
	$Popup.popup()

func _on_continuar_botao_pressed():
	DataPlayer.load_data_dictionary()
	Eventos.chamar_evento()

func _on_Button2_pressed():
	$Popup.hide()
