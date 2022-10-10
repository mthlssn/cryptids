extends CanvasLayer

onready var primeiro_botao := $personagens/player/botao

func _ready():
	primeiro_botao.grab_focus()

func _on_botao_pressed():
	$acoes/agir/botao.grab_focus()
	
