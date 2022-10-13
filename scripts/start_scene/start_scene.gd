extends Control

onready var botao_novo_jogo := $botoes/novo_jogo_botao
onready var titulo := $titulo

onready var popup_configuracoes := $popup_configuracoes
onready var botoes_configuracoes := $popup_configuracoes/botoes_configuracoes
onready var botao_configuracoes_audio := $popup_configuracoes/botoes_configuracoes/audio_botao
onready var botao_configuracoes_controles := $popup_configuracoes/botoes_configuracoes/controles_botao

onready var botoes_controles := $popup_configuracoes/botoes_controles
onready var botao_controle_voltar := $popup_configuracoes/botoes_controles/controles_voltar

func _ready():
	Global.set_valores_iniciais()
	botoes_controles.iniciar()
	
	botao_novo_jogo.grab_focus()
	DataPlayer.load_data(1)
	titulo.text = ""
	
	botoes_controles.hide()

#================ tela inicial

func _on_continuar_botao_pressed():
	DataPlayer.load_data_dictionary()
	Eventos.chamar_evento()

func _on_novo_jogo_botao_pressed():
	Eventos.chamar_evento()

func _on_configuracao_botao_pressed():
	titulo.text = "configurações"
	popup_configuracoes.popup()
	botao_configuracoes_audio.grab_focus()

func _on_sair_botao_pressed():
	get_tree().quit()

#================ configuração

func _on_controles_botao_pressed():
	botoes_controles.chamar_controles()
	botoes_controles.show()
	botoes_configuracoes.hide()
	titulo.text = "configurações - controles"
	botao_controle_voltar.grab_focus()

func _on_configuracoes_voltar_pressed():
	popup_configuracoes.hide()
	titulo.text = ""

#================ controles

func _on_botao_difinir_controles(extra_arg_0): # nome = extra_arg_0
	botoes_controles.selecionar_uma_tecla(extra_arg_0)

func _on_redefinir_teclas_pressed():
	botoes_controles.redefinir()

func _on_controles_voltar_pressed():
	botoes_controles.definir()
	botoes_controles.hide()
	botoes_configuracoes.show()
	titulo.text = "configurações:"
	botao_configuracoes_controles.grab_focus()
