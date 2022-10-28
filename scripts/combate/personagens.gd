extends Control

var combate

var node_aliados
var node_inimigo

var node_persos
var persos

var personagem_chamado = false

var primeira_vez = true

signal pers_apertado
signal status_atualizados

var frame_escuro = preload("res://assets/combate/frame_escuro.png")
var frame_claro = preload("res://assets/combate/frame_claro.png")

func chamar_personagens(tipo_alvo, perso):
	personagem_chamado = true
	combate = get_parent()
	
	atualizar_frame_escuro()
	
	match tipo_alvo:
		"inimigo":
			get_node("inimigo/botao").focus_mode = 2
			get_node("player/botao").focus_mode = 0
			get_node("maria/botao").focus_mode = 0
			get_node("mel/botao").focus_mode = 0
			get_node("inimigo/botao").show()
			$inimigo/botao.grab_focus()
		"aliados":
			get_node("player/botao").focus_mode = 2
			get_node("maria/botao").focus_mode = 2
			get_node("mel/botao").focus_mode = 2
			
			get_node("inimigo/botao").focus_mode = 0
			get_node( perso + "/botao").focus_mode = 0
			
			if perso == "player": 
				$maria/botao.grab_focus()
			else:
				$player/botao.grab_focus()
		"todos_aliados":
			get_node("inimigo/botao").focus_mode = 0
			get_node("player/botao").focus_mode = 2
			get_node("maria/botao").focus_mode = 2
			get_node("mel/botao").focus_mode = 2
			$player/botao.grab_focus()

func montar_personagens(personagens):
	persos = personagens.duplicate()
	
	if personagens.size() == 2:
		get_node("maria/botao").focus_mode = 0
		get_node("maria/botao/personagem").hide()
		get_node("maria/barra_vida").value = 0
		get_node("maria/barra_energia").value = 0
		
		get_node("maria/barra_vida").texture_over = load("res://assets/combate/barra_escura_vida.png")
		get_node("maria/barra_energia").texture_over = load("res://assets/combate/barra_escura_energia.png")
		
		get_node("mel/botao").focus_mode = 0
		get_node("mel/botao/personagem").hide()
		get_node("mel/barra_vida").value = 0
		get_node("mel/barra_energia").value = 0
		
		get_node("mel/barra_vida").texture_over = load("res://assets/combate/barra_escura_vida.png")
		get_node("mel/barra_energia").texture_over = load("res://assets/combate/barra_escura_energia.png")
		
		node_aliados = [get_node("player")]
	else:
		node_aliados = [ get_node("maria"), get_node("mel"), get_node("player")]
	
	var inimigo = personagens[personagens.size() - 1]

	$inimigo/personagem.texture = load(inimigo.imagem_path)
	$inimigo/personagem.rect_position = inimigo.posicao
	
	get_node("inimigo/botao").hide()

func atulizar_personagens(personagem_selecionado):
	for personagens in node_aliados:
		if personagens.name == personagem_selecionado:
			personagens.get_node("botao").texture_normal = frame_claro
		else:
			personagens.get_node("botao").texture_normal = frame_escuro

func atualizar_frame_escuro():
	for personagens in node_aliados:
		personagens.get_node("botao").texture_normal = frame_escuro

func atualizar_label_vida_energia():
	for personagens in node_aliados:
		var bar_v = personagens.get_node("barra_vida")
		bar_v.get_node("valor").show()
		bar_v.get_node("valor").text = String(bar_v.value) + "/" + String(bar_v.max_value)
		
		var bar_e = personagens.get_node("barra_energia")
		bar_e.get_node("valor").text = String(bar_e.value) + "/" + String(bar_e.max_value)
		bar_e.get_node("valor").show()
		
	emit_signal("status_atualizados")

func atualizar_bar_vida_energia():
	node_persos = get_children()
	
	for i in node_aliados.size():
		var vida = persos[i].get_ficha().get_atri_apli("hp")
		var bar_v = node_persos[i].get_node("barra_vida")
		
		var energia = persos[i].get_ficha().get_atri_apli("eng")
		var bar_e = node_persos[i].get_node("barra_energia")
		
		if primeira_vez:
			bar_v.max_value = vida
			bar_e.max_value = energia
			
		bar_v.value = vida
		bar_e.value = energia
		
	var vida = persos[persos.size()-1].get_ficha().get_atri_apli("hp")
	var bar_v = node_persos[node_persos.size() - 1].get_node("botao/barra_vida")
	
	if primeira_vez:
		bar_v.max_value = vida
			
	bar_v.value = vida
	
	primeira_vez = false
	atualizar_label_vida_energia()

func emitir_sinal_per():
	emit_signal("pers_apertado")

func _on_botao_pressed(extra_arg_0):
	if extra_arg_0 != "inimigo":
		get_node(extra_arg_0).get_node("botao").texture_normal = frame_claro
		
		var node = get_node(extra_arg_0)
		node.get_node("botao/personagem/setinha").hide()
		node.get_node("botao/personagem/animation_player").stop()
	
	combate.set_personagem_apertado(extra_arg_0)
	emitir_sinal_per()

func _on_botao_focus_entered(extra_arg_0):
	var node = get_node(extra_arg_0)
	
	node.get_node("botao/personagem/setinha").show()
	node.get_node("botao/personagem/animation_player").play("setinha")

func _on_botao_focus_exited(extra_arg_0):
	var node = get_node(extra_arg_0)
	
	node.get_node("botao/personagem/setinha").hide()
	node.get_node("botao/personagem/animation_player").stop()

func _on_botao_inimigo_focus_entered():
	$inimigo/animation_player.play("barra_selecionada")

func _on_botao_inimigo_focus_exited():
	$inimigo/animation_player.stop()
