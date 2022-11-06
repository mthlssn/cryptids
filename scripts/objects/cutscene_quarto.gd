extends "objects.gd"

var nt # node_tilemap
var na # node_animation_player

func chamar_animacao(tilemap):
	nt = tilemap
	na = nt.get_node("../animation_player")
	
	Global.set_cena_atual(9)
	Transition.fade(self, "", nt.get_node("players").velocidade, "fade", true)

func func_transicao():
	nt.get_node("../camera").mudar_camera(true)
	na.play("cutscene_quarto")
	
func dialogo():
	na.stop(false)
	DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
	DialogBox.set_node_cutscene(self)
	dialogo_resource = load("res://data/dialogs/pt_BR/maria/maria_quarto_player2.tres")

func pausar():
	na.stop(false)

func iniciou():
	na.play("cutscene_quarto")
	
func chamar_cutscene_acordando():
	Global.set_pausar(false)
	Global.set_mover(false)
				
	Global.get_node_demo().get_node("animation_player").play("cutscene_acordando")
	Global.get_node_demo().arrumar_casa3()
	
	yield(Global.get_node_demo().get_node("animation_player"), "animation_finished")
	
	DataPlayer.salvar()
	
	Global.set_pausar(true)
	Global.set_mover(true)

func arrumando_a_fila():
	Global.set_players(["res://scenes/personagens/player.tscn"])
	Global.set_posicao_players([Vector2(432,-1008)])
	Global.set_direcao_players([Vector2(1,0)])
	
	nt.get_node("players").arrumar_fila()
