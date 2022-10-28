extends CanvasLayer

var personagem_apertado

var acao_apertada = null
var acao_selecionada = null

var opcao_apertada
var opcao_selecionada = null

var personagens

var _combate_finalizado = false

var tela

var _vez = -1
var _node_vez = null
var _ordem : Array

var inimigo

onready var node_a := $acoes
onready var node_d := $dialog
onready var node_o := $opcoes
onready var node_p := $personagens

var rng = RandomNumberGenerator.new()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		match tela:
			"opcoes":
				node_o.hide()
				acao_apertada = null
				node_o.emitir_sinal_opc()
				opcao_selecionada = null
			"personagens":
				personagem_apertado = null
				acao_apertada = "agir"
				node_p.emitir_sinal_per()

func chamar_combate(perso):
	Global.get_node_demo().get_tree().paused = true
	Global.set_pausar(false)
	
	rng.randomize()
	
	personagens = perso
	inimigo = personagens[personagens.size() - 1]
	
	match inimigo:
		"gamba":
			$animation_player.play("start_combate_gamba")
	
	personagens.pop_back()
	var aliados = personagens.duplicate()
	for i in aliados.size():
		personagens[i] = load("res://scripts/combate/fichas/ficha_"+ aliados[i] +".gd").new()
	
	personagens.resize(personagens.size() + 1)
	personagens[personagens.size() - 1] = load("res://scripts/combate/fichas/ficha_"+ inimigo +".gd").new()
	
	node_p.montar_personagens(personagens.duplicate())
	
	for i in personagens.size():
		personagens[i].abrir_ficha(self)
	
	node_p.atualizar_bar_vida_energia()
	
	_ordem = gerar_ordem(personagens.duplicate())
	
	yield($animation_player, "animation_finished")
	
	node_d.chamar_dialogo(personagens[personagens.size() - 1].get_fala())
	yield(node_d, "dialogo_fechado")
	
	$timer.start()

func rodar_combate():
	var jogador = null
	
	_vez += 1
	
	if _combate_finalizado:
		return finalizar_combate()
	
	if _vez == _ordem.size():
		_vez = -1
	else:
		if _node_vez:
			_vez -= 1
		else:
			_node_vez = _ordem[_vez]
		
		var nome_node = _node_vez.get_ficha().get_nome()
		if nome_node == Global.get_nome_player():
			node_p.atulizar_personagens("player")
			jogador = "player"
		elif nome_node == "Maria":
			node_p.atulizar_personagens("maria")
			jogador = "maria"
		elif nome_node == "Biscoito":
			node_p.atulizar_personagens("biscoito")
			jogador = "biscoito"
		else: #inimigo
			var texto = _node_vez.acao_inimigo(personagens)
			
			node_d.chamar_dialogo(texto)
			
			yield(node_d, "dialogo_fechado")
			
			jogador = null
			set_null()
		
		if jogador:
			node_d.hide()
			
			if not acao_apertada:
				node_a.chamar_acoes()
				
				if not acao_selecionada:
					$acoes/agir/botao.grab_focus()
				else:
					get_node("acoes/" + acao_selecionada + "/botao").grab_focus()
				
				yield(node_a, "acao_apertada")
			
			match acao_apertada:
				"agir":
					tela = "opcoes"
					node_o.chamar_opcoes_agir(_node_vez.skills, _node_vez.skills_desc)
					
					if not opcao_selecionada:
						$opcoes/container_opcoes/opcao1.grab_focus()
					else:
						get_node("opcoes/container_opcoes/opcao" + String(opcao_selecionada + 1)).grab_focus()
						
					opcao_apertada = null
					yield(node_o, "opcao_apertada")
					
					var num = null
					match opcao_apertada:
						"opcao1":
							num = 0
						"opcao2":
							num = 1
						"opcao3":
							num = 2
						"opcao4":
							num = 3
					
					if num != null:
						tela = "personagens"
						node_p.chamar_personagens(_node_vez.skills_alvo[num], jogador)
						
						personagem_apertado = null
						yield(node_p, "pers_apertado")
						
						var alvo =  null
						match personagem_apertado:
							"player":
								alvo = personagens[0]
							"maria":
								alvo = personagens[1]
							"biscoito":
								alvo = personagens[2]
							"inimigo":
								alvo = personagens[personagens.size()-1]
								
						if alvo != null:
							node_o.hide()
							
							node_d.chamar_dialogo(_node_vez.usar_skill(num, alvo))
							yield(node_d, "dialogo_fechado")
							
							if personagem_apertado == "inimigo":
								node_p.get_node("inimigo/botao").hide()
							
							set_null()
				"itens":
					tela = "opcoes"
					node_o.chamar_opcoes_itens()
					
					if not opcao_selecionada:
						$opcoes/container_opcoes/opcao1.grab_focus()
					else:
						get_node("opcoes/container_opcoes/opcao" + String(opcao_selecionada + 1)).grab_focus()
					
					opcao_apertada = null
					yield(node_o, "opcao_apertada")
					
					var num = null
					match opcao_selecionada:
						"opcao1":
							num = 0
					
					if num != null:
						tela = "personagens"
						var itens = Inventario.get_inventario()
							
						node_p.chamar_personagens(itens[num][2], jogador)
						personagem_apertado = null
						yield(node_p, "pers_apertado")
							
						var alvo = null
						match personagem_apertado:
							"player":
								alvo = personagens[0]
							"maria":
								alvo = personagens[1]
							"biscoito":
								alvo = personagens[2]
							"inimigo":
								alvo = personagens[personagens.size()-1]
							
						if alvo != null:
							node_o.hide()
							node_d.chamar_dialogo(Inventario.usar_item1(alvo, self))
							node_p.atualizar_bar_vida_energia()
							yield(node_d, "dialogo_fechado")
							
							set_null()
				"pular":
					_node_vez.get_ficha().regenerar_energia("con")
					_node_vez = null
					node_d.chamar_dialogo(["Se desesperou, hm, é apenas um iniciante"])
					node_p.atualizar_bar_vida_energia()
					yield(node_d, "dialogo_fechado")
					
					acao_apertada = null
					acao_selecionada = null
				"fugir":
					var cont = 0
					
					for i in personagens.size():
						cont = cont + personagens[i].get_ficha().get_atri_apli("spd")
					
					var spd_ini = personagens[personagens.size() - 1].get_ficha().get_atri_apli("spd")
					cont = cont - spd_ini
					
					var media = cont / (personagens.size() - 1)
					
					if media >= spd_ini:
						node_d.chamar_dialogo(["Corra, não é necessário enfrentar seus medos!"])
						yield(node_d, "dialogo_fechado")
						_combate_finalizado = true
					else:
						node_d.chamar_dialogo(["Ele não vai te deixar escapar!"])
						yield(node_d, "dialogo_fechado")
					
					_node_vez = null
					set_null()
					
	$timer.start()

func finalizar_combate():
	$animation_player.play("close_combate")
	yield($animation_player, "animation_finished")
	
	Global.get_node_demo().get_tree().paused = false
	Global.set_pausar(true)
	
	if personagens[personagens.size()-1].get_ficha().get_nome() == "Gambá":
		var nd = Global.get_node_demo() #node_demo
		
		nd.get_node("animation_player").play("gamba")
		nd.get_node("tilemap/arbusto_grande2").dg_interacao = true
		nd.get_node("tilemap/arbusto_grande2").func_interacao = false
	
	queue_free()

func gerar_ordem(perso):
	var _array_spd : Array
	_array_spd.resize(perso.size())
	
	for i in perso.size():
		_array_spd[i] = perso[i].get_ficha().get_atri_apli("spd")
	
	for i in _array_spd.size():
		for j in _array_spd.size():
			var temp 
			if _array_spd[i] == _array_spd[j]:
				if rng.randi_range(1, 10) > 5:
					temp = perso[i]
					perso[i] = perso[j]
					perso[j] = temp
			elif _array_spd[i] > _array_spd[j]:
				temp = _array_spd[i]
				_array_spd[i] = _array_spd[j]
				_array_spd[j] = temp
				
				temp = perso[i]
				perso[i] = perso[j]
				perso[j] = temp
	return perso

func set_background():
	match inimigo:
		"gamba":
			$background.texture = load("res://assets/combate/background.jpeg")

func set_null():
	personagem_apertado = null
	acao_selecionada = null
	acao_apertada = null
	opcao_selecionada = null

func get_node_vez():
	return _node_vez

func set_node_vez(node):
	_node_vez = node

func set_combate_finalizado(finalizado):
	_combate_finalizado = finalizado

func set_personagem_apertado(apertado):
	personagem_apertado = apertado

func set_acao_apertada(apertada):
	acao_apertada = apertada

func set_opcao_apertada(apertada):
	opcao_apertada = apertada

func set_acao_selecionada(selecionada):
	acao_selecionada = selecionada

func set_opcao_selecionada(selecionada):
	opcao_selecionada = selecionada

func _on_timer_timeout():
	rodar_combate()
