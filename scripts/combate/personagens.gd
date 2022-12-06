extends Control

var combate

var node_aliados
var node_inimigo

var node_persos
var persos

var personagem_chamado = false

var primeira_vez = true

# player - maria - biscoito
var personagens_mortos = [false , false , false]

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
			get_node("biscoito/botao").focus_mode = 0
			get_node("inimigo/botao").show()
			$inimigo/botao.grab_focus()
		"aliados":
			if not personagens_mortos[0]:
				get_node("player/botao").focus_mode = 2
			
			if not personagens_mortos[1]:
				get_node("maria/botao").focus_mode = 2
			
			if not personagens_mortos[2]:
				get_node("biscoito/botao").focus_mode = 2
			
			get_node("inimigo/botao").focus_mode = 0
			get_node( perso + "/botao").focus_mode = 0
			
			if perso == "player": 
				$maria/botao.grab_focus()
				if personagens_mortos[1]:
					 $biscoito/botao.grab_focus()
			else:
				$player/botao.grab_focus()
				if personagens_mortos[0]:
					 $biscoito/botao.grab_focus()

func montar_personagens(personagens):
	persos = personagens.duplicate()
	
	if personagens.size() == 2:
		get_node("maria/botao").focus_mode = 0
		get_node("maria/botao/personagem").hide()
		get_node("maria/barra_vida").value = 0
		get_node("maria/barra_energia").value = 0
		
		get_node("maria/barra_vida").texture_over = load("res://assets/combate/barra_escura_vida.png")
		get_node("maria/barra_energia").texture_over = load("res://assets/combate/barra_escura_energia.png")
		
		get_node("biscoito/botao").focus_mode = 0
		get_node("biscoito/botao/personagem").hide()
		get_node("biscoito/barra_vida").value = 0
		get_node("biscoito/barra_energia").value = 0
		
		get_node("biscoito/barra_vida").texture_over = load("res://assets/combate/barra_escura_vida.png")
		get_node("biscoito/barra_energia").texture_over = load("res://assets/combate/barra_escura_energia.png")
		
		node_aliados = [get_node("player")]
	else:
		get_node("maria/botao").focus_mode = 2
		get_node("maria/botao/personagem").show()
		get_node("maria/barra_vida").value = 0
		get_node("maria/barra_energia").value = 0
		
		get_node("maria/barra_vida").texture_over = load("res://assets/combate/barra_vida.png")
		get_node("maria/barra_energia").texture_over = load("res://assets/combate/barra_energia.png")
		
		get_node("biscoito/botao").focus_mode = 2
		get_node("biscoito/botao/personagem").show()
		get_node("biscoito/barra_vida").value = 0
		get_node("biscoito/barra_energia").value = 0
		
		get_node("biscoito/barra_vida").texture_over = load("res://assets/combate/barra_vida.png")
		get_node("biscoito/barra_energia").texture_over = load("res://assets/combate/barra_energia.png")
		
		node_aliados = [ get_node("maria"), get_node("biscoito"), get_node("player")]
		
	get_node("inimigo/botao").hide()

func atualizar_personagens(personagem_selecionado):
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
	
	$inimigo/botao.hide()
	
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
	
	primeira_vez = false
	
	atualizar_vida_inimigo()
	atualizar_label_vida_energia()

func atualizar_buff_debuff(medos, debuff):
	node_persos = get_children()
	
	adicionar_buff_debuff("player", "medo", medos[0])
	
	if persos.size() >= 4:
		adicionar_buff_debuff("maria", "medo", medos[1])
		adicionar_buff_debuff("biscoito", "medo", medos[2])
	
	if debuff:
		adicionar_buff_debuff("inimigo", "debuff", -1)
	else:
		remover_buff_debuff("inimigo", "debuff")

func atualizar_vida_inimigo():
	var vida = persos[persos .size()-1].get_ficha().get_atri_apli("hp")
	var bar_v = node_persos[node_persos.size() - 1].get_node("botao/barra_vida")
	
	if primeira_vez:
		bar_v.max_value = vida
	
	bar_v.value = vida

func adicionar_buff_debuff(alvo, tipo, quantidade):
	match quantidade:
		1:
			get_node(alvo + "/buffs_debuffs/medo").texture = load("res://assets/combate/medo1.png")
		2:
			get_node(alvo + "/buffs_debuffs/medo").texture = load("res://assets/combate/medo2.png")
		3:
			get_node(alvo + "/buffs_debuffs/medo").texture = load("res://assets/combate/medo3.png")
	
	if alvo == "inimigo":
		get_node(alvo + "/botao/buffs_debuffs").show()
		get_node(alvo + "/botao/buffs_debuffs/" + tipo).show()
	else:
		get_node(alvo + "/buffs_debuffs").show()
		get_node(alvo + "/buffs_debuffs/" + tipo).show()
	
	if quantidade == 0:
		remover_buff_debuff(alvo, tipo)

func remover_buff_debuff(alvo, tipo):
	if alvo == "inimigo":
		get_node(alvo + "/botao/buffs_debuffs/" + tipo).hide()
	else:
		get_node(alvo + "/buffs_debuffs/" + tipo).hide()

func set_morto(node):
	match node:
		"player":
			personagens_mortos[0] = true
		"maria":
			personagens_mortos[1] = true
		"biscoito":
			personagens_mortos[2] = true
	
	get_node(node + "/botao/personagem").hide()
	get_node(node + "/buffs_debuffs").hide()
	
	get_node(node + "/barra_vida").texture_over = load("res://assets/combate/barra_escura_vida.png")
	get_node(node + "/barra_energia").texture_over = load("res://assets/combate/barra_escura_energia.png")
	
	get_node(node + "/barra_vida/valor").text = " "
	get_node(node + "/barra_energia/valor").text = " "

func emitir_sinal_per():
	get_node("inimigo/botao").hide()
	emit_signal("pers_apertado")

func set_textures():
	var nodes = get_children()
	
	nodes.pop_back()
	
	for node in nodes:
		node.get_node("botao").texture_normal = frame_escuro

func _on_botao_pressed(extra_arg_0):
	if extra_arg_0 != "inimigo":
		get_node(extra_arg_0).get_node("botao").texture_normal = frame_claro
		
		var node = get_node(extra_arg_0)
		node.get_node("botao/personagem/setinha").hide()
		node.get_node("botao/personagem/animation_player").stop()
	
	combate.set_personagem_apertado(extra_arg_0)
	emit_signal("pers_apertado")

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
