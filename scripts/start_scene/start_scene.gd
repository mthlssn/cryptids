extends Control

onready var botao_jogar := $botoes/jogar_botao
onready var titulo := $titulo

#================ popup_jogar:
onready var popup_jogar := $popup_jogar
onready var botoes_jogar := $popup_jogar/botoes_jogar
onready var botao_jogar_voltar:= $popup_jogar/botoes_jogar/jogar_voltar
onready var botoes_opcoes := $popup_jogar/botoes_opcoes
onready var botoes_opcoes_continuar := $popup_jogar/botoes_opcoes/continuar_botao

#================ popup_configurações:
onready var popup_configuracoes := $popup_configuracoes
onready var botoes_configuracoes := $popup_configuracoes/botoes_configuracoes
onready var botao_configuracoes_voltar := $popup_configuracoes/botoes_configuracoes/configuracoes_voltar
onready var botao_configuracoes_controles := $popup_configuracoes/botoes_configuracoes/controles_botao
onready var botao_configuracoes_video := $popup_configuracoes/botoes_configuracoes/video_botao
onready var botoes_controles := $popup_configuracoes/botoes_controles
onready var botao_controle_voltar := $popup_configuracoes/botoes_controles/controles_voltar
onready var botoes_video := $popup_configuracoes/botoes_video
onready var botao_video_voltar := $popup_configuracoes/botoes_video/video_voltar

func _ready():
	Global.set_valores_iniciais()
	
	botao_jogar.grab_focus()
	titulo.text = ""
	
	botoes_opcoes.hide()
	
	botoes_controles.hide()
	botoes_video.hide()

#================ tela_inicial

func _on_jogar_botao_pressed():
	botoes_jogar.chamar_jogar()
	titulo.text = "jogar:"
	popup_jogar.popup()
	botao_jogar_voltar.grab_focus()

func _on_configuracao_botao_pressed():
	titulo.text = "configurações:"
	popup_configuracoes.popup()
	botao_configuracoes_voltar.grab_focus()

func _on_sair_botao_pressed():
	get_tree().quit()

#================ jogar

func _on_botao_escolher_save(extra_arg_0): # key_save = extra_arg_0
	var nome_save = botoes_jogar.selecionar_um_save(extra_arg_0)
	if nome_save:
		titulo.text = "jogar/" + nome_save + ":"
		botoes_jogar.hide()
		botoes_opcoes.show()
		botoes_opcoes_continuar.grab_focus()

func _on_jogar_voltar_pressed():
	popup_jogar.hide()
	titulo.text = ""

#================ jogar - opções

func _on_continuar_botao_pressed():
	botoes_jogar.continuar_save()

func _on_apagar_botao_pressed():
	botoes_jogar.apagar_save()
	botoes_jogar.chamar_jogar()
	botoes_jogar.show()
	botoes_opcoes.hide()
	titulo.text = "jogar:"
	botao_jogar_voltar .grab_focus()

func _on_jogar_opcoes_voltar_pressed():
	botoes_jogar.show()
	botoes_opcoes.hide()
	titulo.text = "jogar:"
	botao_jogar_voltar .grab_focus()

#================ configuração

func _on_controles_botao_pressed():
	botoes_controles.chamar_controles()
	botoes_controles.show()
	botoes_configuracoes.hide()
	titulo.text = "configurações/controles:"
	botao_controle_voltar.grab_focus()

func _on_video_botao_pressed():
	botoes_video.chamar_video()
	botoes_video.show()
	botoes_configuracoes.hide()
	titulo.text = "configurações/vídeo:"
	botao_video_voltar.grab_focus()

func _on_configuracoes_voltar_pressed():
	popup_configuracoes.hide()
	titulo.text = ""

#================ configuração - controles

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

#================ configuração - vídeo

func _on_botao_definir_tamanho_tela(extra_arg_0): # tamanho_tela = extra_arg_0
	botoes_video.selecionar_tamanho(extra_arg_0)

func _on_video_voltar_pressed():
	botoes_video.fechar()
	botoes_video.hide()
	botoes_configuracoes.show()
	titulo.text = "configurações:"
	botao_configuracoes_video.grab_focus()
