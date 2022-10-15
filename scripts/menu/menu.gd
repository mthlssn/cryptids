extends CanvasLayer

var node_pause

#================ popup_configurações:
onready var titulo := $titulo
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
	hide()
	botoes_controles.hide()
	botoes_video.hide()

func _input(event):
	if event.is_action_pressed("ui_cancel") && Global.get_pausar() && self.visible == false:
		pause()
		
func pause():
	node_pause = Global.get_node_demo()
	if node_pause:
		if node_pause.get_tree().paused == false:
			node_pause.get_tree().paused = true
			show()
			$botoes/continuar_botao.grab_focus()
		else:
			node_pause.get_tree().paused = false
			hide()

func _on_continuar_botao_pressed():
	pause()

func _on_configuracao_botao_pressed():
	titulo.text = "configurações:"
	popup_configuracoes.popup_centered()
	botao_configuracoes_voltar.grab_focus()
	$botoes.hide()

func _on_tela_inicial_salvar_botao_pressed():
	DataPlayer.salvar()
	pause()
	Transition.fade(node_pause, "res://scenes/start_scene/start_scene.tscn", 1, "fade_2")

func _on_tela_inicial_sem_salvar_botao_pressed():
	pause()
	Transition.fade(node_pause, "res://scenes/start_scene/start_scene.tscn", 1, "fade_2")

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
	$botoes.show()
	$botoes/configuracao_botao.grab_focus()
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
