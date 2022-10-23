extends CanvasLayer

var personagem_selecionado
var acao_selecionada
var opcao_selecionada

var personagens

var _combate_finalizado = false

var _vez = -1
var _node_vez = null
var _ordem : Array

onready var node_a := $acoes
onready var node_d := $dialog
onready var node_o := $opcoes
onready var node_p := $personagens

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()

func chamar_combate(perso):
	Global.get_node_demo().get_tree().paused = true
	personagens = perso
	var inimigo = personagens[personagens.size() - 1]
	
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
		elif nome_node == "Mel":
			node_p.atulizar_personagens("mel")
			jogador = "mel"
		else: #inimigo
			var texto = _node_vez.acao_inimigo(personagens)
			node_p.atualizar_bar_vida_energia()
			
			node_d.chamar_dialogo(texto)
			
			yield(node_d, "dialogo_fechado")
			jogador = null
		
		if jogador:
			node_d.hide()
			node_a.chamar_acoes()
			yield(node_a, "acao_apertada")
			
			match acao_selecionada:
				"agir":
					var voltar = false
					node_o.chamar_opcoes_agir(_node_vez.skills, _node_vez.skills_desc)
					yield(node_o, "opcao_apertada")
					
					var num
					match opcao_selecionada:
						"opcao1":
							num = 0
						"opcao2":
							num = 1
						"opcao3":
							num = 2
						"opcao4":
							num = 3
						"voltar":
							voltar = true
					
					if not voltar:
						node_p.chamar_personagens(_node_vez.skills_alvo[num], jogador)
						yield(node_p, "pers_apertado")
						
						var alvo
						match personagem_selecionado:
							"player":
								alvo = personagens[0]
							"maria":
								alvo = personagens[1]
							"mel":
								alvo = personagens[2]
							"inimigo":
								alvo = personagens[personagens.size()-1]
						
						node_o.hide()
						node_d.chamar_dialogo(_node_vez.usar_skill(num, alvo))
						node_p.atualizar_bar_vida_energia()
						yield(node_d, "dialogo_fechado")
				"itens":
					node_o.chamar_opcoes_itens()
					yield(node_o, "opcao_apertada")
					
					match opcao_selecionada:
						"opcao1":
							var itens = Inventario.get_inventario()
							
							node_p.chamar_personagens(itens[0][2], jogador)
							yield(node_p, "pers_apertado")
							
							var alvo
							match personagem_selecionado:
								"player":
									alvo = personagens[0]
								"maria":
									alvo = personagens[1]
								"mel":
									alvo = personagens[2]
								"inimigo":
									alvo = personagens[personagens.size()-1]
							
							node_o.hide()
							node_d.chamar_dialogo(Inventario.usar_item1(alvo, self))
							node_p.atualizar_bar_vida_energia()
							yield(node_d, "dialogo_fechado")
				"pular":
					_node_vez.get_ficha().regenerar_energia("con")
					_node_vez = null
					node_d.chamar_dialogo("Se desesperou, hm, é apenas um iniciante")
					node_p.atualizar_bar_vida_energia()
					yield(node_d, "dialogo_fechado")
				"fugir":
					var cont = 0
					
					for i in personagens.size():
						cont = cont + personagens[i].get_ficha().get_atri_apli("spd")
					
					var spd_ini = personagens[personagens.size() - 1].get_ficha().get_atri_apli("spd")
					cont = cont - spd_ini
					
					var media = cont / (personagens.size() - 1)
					
					if media >= spd_ini:
						node_d.chamar_dialogo("Corra, não é necessário enfrentar seus medos!")
						yield(node_d, "dialogo_fechado")
						_combate_finalizado = true
					else:
						node_d.chamar_dialogo("Ele n vai te deixar escapar!")
						yield(node_d, "dialogo_fechado")
						
					_node_vez = null
					
	$timer.start()

func finalizar_combate():
	Global.get_node_demo().get_tree().paused = false
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

func get_node_vez():
	return _node_vez

func set_node_vez(node):
	_node_vez = node

func set_combate_finalizado(finalizado):
	_combate_finalizado = finalizado

func set_personagem_selecionado(selecionado):
	personagem_selecionado = selecionado

func set_acao_selecionada(selecionada):
	acao_selecionada = selecionada

func set_opcao_selecionada(selecionada):
	opcao_selecionada = selecionada

func _on_timer_timeout():
	rodar_combate()
