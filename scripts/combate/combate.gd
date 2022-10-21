extends CanvasLayer

onready var primeiro_botao := $personagens/player/botao
var sla = load("res://data/dialogs/pt_BR/cena_3/saida_de_baixo.tres")

func _ready():
	primeiro_botao.grab_focus()
	DialogBox.call_dialog_box(false, sla.msg_queue, null, null)

func _on_botao_pressed():
	$acoes/agir/botao.grab_focus()
