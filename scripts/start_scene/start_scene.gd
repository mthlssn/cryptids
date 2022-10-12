extends Control

onready var botao_novo_jogo = $botoes/novo_jogo_botao
onready var popup_config = $popup_configuracoes
onready var botao_voltar_config = $popup_configuracoes/voltar

func _ready():
	Global.set_valores_iniciais()
	botao_novo_jogo.grab_focus()
	DataPlayer.load_data(1)

func _on_novo_jogo_botao_pressed():
	Eventos.chamar_evento()

func _on_sair_botao_pressed():
	get_tree().quit()

func _on_configuracao_botao_pressed():
	popup_config.popup()
	botao_voltar_config.grab_focus()

func _on_continuar_botao_pressed():
	DataPlayer.load_data_dictionary()
	Eventos.chamar_evento()

func _on_voltar_pressed():
	popup_config.hide()
