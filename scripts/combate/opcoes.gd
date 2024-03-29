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

func chamar_opcoes_agir(opcoes, descricoes):
	combate = get_parent()
	_opcoes = opcoes.duplicate()
	_descricoes = descricoes.duplicate()
	
	atualizar_botoes()
	show()

func chamar_opcoes_itens():
	combate = get_parent()
	var itens = Inventario.get_inventario()
	
	itens.resize(4)
	_opcoes.resize(4)
	_descricoes.resize(4)
	
	for i in 4:
		if itens[i]:
			_opcoes[i] = itens[i][0]
			_descricoes[i] = itens[i][1]
		else:
			_opcoes[i] = "nada"
	
	atualizar_botoes()
	show()

func atualizar_botoes():
	var botoes = get_node("container_opcoes").get_children()
	
	for i in botoes.size():
		botoes[i].get_node("borda").hide()
		botoes[i].focus_mode = 2
		botoes[i].disabled = false
			
		botoes[i].text = _opcoes[i]
		
		if _opcoes[i] == "nada":
			#botoes[i].focus_mode = 0
			botoes[i].disabled = true

func emitir_sinal_opc():
	emit_signal("opcao_apertada")

func _on_opcao_pressed(extra_arg_0):
	get_node("container_opcoes/" + extra_arg_0 + "/borda").show()
	
	combate.set_opcao_apertada(extra_arg_0)
	emitir_sinal_opc()

func _on_opcao_focus_entered(extra_arg_0):
	texto.text = ""
	combate.set_opcao_selecionada(extra_arg_0)
	get_node("container_opcoes/opcao" + String(extra_arg_0 + 1) + "/borda").hide()
	
	if extra_arg_0 <= _descricoes.size() -1 and _opcoes[extra_arg_0] != "nada":
		texto.text = _descricoes[extra_arg_0]
