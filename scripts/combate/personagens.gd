extends Control

var combate

var node_aliados

signal pers_apertado

var frame_escuro = preload("res://assets/combate/frame_escuro.png")
var frame_claro = preload("res://assets/combate/frame_claro.png")

func chamar_personagens(tipo_alvo, perso):
	combate = get_parent()
	
	atualizar_frame_escuro()
	
	match tipo_alvo:
		"inimigo":
			get_node("player/botao").focus_mode = 0
			get_node("maria/botao").focus_mode = 0
			get_node("mel/botao").focus_mode = 0
			$inimigo/botao.grab_focus()
		"aliados":
			get_node("inimigo/botao").focus_mode = 0
			get_node( perso + "/botao").focus_mode = 0
			$maria/botao.grab_focus()
			$player/botao.grab_focus()

func montar_personagens(personagens):
	if personagens.size() == 2:
		get_node("maria/botao").focus_mode = 0
		get_node("maria/botao/personagem").hide()
		get_node("maria/barra_vida").value = 0
		get_node("maria/barra_energia").value = 0
		
		get_node("mel/botao").focus_mode = 0
		get_node("mel/botao/personagem").hide()
		get_node("mel/barra_vida").value = 0
		get_node("mel/barra_energia").value = 0
		
		node_aliados = [get_node("player")]
	else:
		node_aliados = [ get_node("maria"), get_node("mel"), get_node("player")]
	
	var inimigo = personagens[personagens.size() - 1]

	$inimigo/personagem.texture = load(inimigo.imagem_path)
	$inimigo/personagem.rect_position = inimigo.posicao

func atulizar_personagens(personagem_selecionado):
	for personagens in node_aliados:
		if personagens.name == personagem_selecionado:
			personagens.get_node("botao").texture_normal = frame_claro
		else:
			personagens.get_node("botao").texture_normal = frame_escuro

func atualizar_frame_escuro():
	for personagens in node_aliados:
		personagens.get_node("botao").texture_normal = frame_escuro

func atualizar_vida_energia():
	for personagens in node_aliados:
		if  personagens.name != "inimigo":
			var bar_v = personagens.get_node("barra_vida")
			var bar_e = personagens.get_node("barra_energia")
			
			bar_v.get_node("valor").hide()
			bar_e.get_node("valor").hide()
			
			bar_v.get_node("valor").text = String(bar_v.value) + "/" + String(bar_v.max_value)
			bar_e.get_node("valor").text = String(bar_e.value) + "/" + String(bar_e.max_value)

func _on_botao_pressed(extra_arg_0):
	if extra_arg_0 != "inimigo":
		get_node(extra_arg_0).get_node("botao").texture_normal = frame_claro
		
		var node = get_node(extra_arg_0)
		node.get_node("botao/personagem/setinha").hide()
		node.get_node("botao/personagem/animation_player").stop()
	
	combate.set_personagem_selecionado(extra_arg_0)
	emit_signal("pers_apertado")

func _on_botao_focus_entered(extra_arg_0):
	var node = get_node(extra_arg_0)
	
	node.get_node("botao/personagem/setinha").show()
	node.get_node("botao/personagem/animation_player").play("setinha")

func _on_botao_focus_exited(extra_arg_0):
	var node = get_node(extra_arg_0)
	
	node.get_node("botao/personagem/setinha").hide()
	node.get_node("botao/personagem/animation_player").stop()
