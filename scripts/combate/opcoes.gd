extends NinePatchRect

var combate

signal opcao_apertada

onready var texto := $container_texto/texto
onready var opcao1 := $container_opcoes/opcao1
onready var opcao2 := $container_opcoes/opcao2
onready var opcao3 := $container_opcoes/opcao3
onready var opcao4 := $container_opcoes/opcao4

var _opcoes : Array
var _descricoes : Array

func chamar_opcoes(opcoes, descricoes):
	combate = get_parent()
	_opcoes = opcoes
	_descricoes = descricoes
	
	atualizar_botoes()
	show()
	opcao1.grab_focus()

func atualizar_botoes():
	var botoes = get_node("container_opcoes").get_children()
	
	for i in botoes.size():
		botoes[i].focus_mode = 2
		botoes[i].disabled = false
			
		botoes[i].text = _opcoes [i]
		
		if _opcoes [i] == "nada":
			botoes[i].focus_mode = 0
			botoes[i].disabled = true

func _on_opcao_pressed(extra_arg_0):
	combate.set_opcao_selecionada(extra_arg_0)
	emit_signal("opcao_apertada")

func _on_opcao_focus_entered(extra_arg_0):
	texto.text = _descricoes[extra_arg_0]
