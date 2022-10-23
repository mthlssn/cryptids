extends CanvasLayer

var personagem_selecionado
var acao_selecionada
var opcao_selecionada

var personagens

var _finalizar_combate = false

var vez = -1
var node_vez 
var ordem : Array

onready var node_a := $acoes
onready var node_d := $dialog
onready var node_o := $opcoes
onready var node_p := $personagens

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	Global.set_nome_player("Thalisson")
	#var sla = ["opaaaa", "nada"]
	#DialogBox.call_dialog_box(false, sla, null, null)
	#var ficha = Ficha.new(4, 5, 6, 7, 3)
	#get_node("opcoes").chamar_opcoes(["Intimidar", "Arranhar", "nada", "nada"], ["ele intimida", "ele arranha"])
	
	#get_node("personagens").chamar_personagens()
	#personagem_vez = "maria"
	#get_node("personagens").atulizar_personagens(personagem_vez)
	#get_node("acoes").chamar_acoes()
	#get_node("opcoes").chamar_opcoes(["Intimidar", "Arranhar", "nada", "nada"], ["ele intimida", "ele arranha"])
	
	#print(ficha.get_all()
	
	chamar_combate(["player", "sarue"])
	#var opa = node_a.chamar_acoes()
	#print(opa)

func chamar_combate(perso):
	personagens = perso
	var inimigo = personagens[personagens.size() - 1]
	
	personagens.pop_back()
	var aliados = personagens.duplicate()
	for i in aliados.size():
		personagens[i] = load("res://scripts/combate/fichas/ficha_"+ aliados[i] +".gd").new()
	
	personagens.resize(personagens.size() + 1)
	personagens[personagens.size() - 1] = load("res://scripts/combate/fichas/ficha_"+ inimigo +".gd").new()
	
	node_p.montar_personagens(personagens.duplicate())
	node_p.atualizar_vida_energia()
	
	for i in personagens.size():
		personagens[i].abrir_ficha()
	
	ordem = gerar_ordem(personagens.duplicate())
	
	rodar_combate()

func rodar_combate():
	var jogador = null
	vez += 1
	
	if _finalizar_combate:
		return
	
	if vez == ordem.size():
		vez = -1
	else:
		node_vez = ordem[vez]
		
		var nome_node = node_vez.get_ficha().get_nome()
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
			node_d.chamar_dialogo(node_vez.acao_inimigo(personagens))
			yield(node_d, "dialogo_fechado")
			jogador = null
		
		if jogador:
			node_d.hide()
			node_a.chamar_acoes()
			yield(node_a, "acao_apertada")
			
			match acao_selecionada:
				"agir":
					node_o.chamar_opcoes(node_vez.skills, node_vez.skills_desc)
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
					
					node_p.chamar_personagens(node_vez.skills_alvo[num], jogador)
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
					
					node_d.chamar_dialogo(node_vez.usar_skill(num, alvo))
					yield(node_d, "dialogo_fechado")
				"itens":
					node_o.chamar_opcoes(node_vez.itens, node_vez.itens_desc)
					yield(node_o, "opcao_apertada")
					
					node_p.chamar_personagens()
					yield(node_p, "pers_apertado")
					
					node_o.hide()
				"pular":
					node_vez.get_ficha().regenerar_energia()
					node_d.chamar_dialogo("Se desesperou, hm, é apenas um iniciante")
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
						_finalizar_combate = true
					else:
						node_d.chamar_dialogo("Ele n vai te deixar escapar!")
						yield(node_d, "dialogo_fechado")
	$timer.start()

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

func set_finalizar_combate(finalizar):
	_finalizar_combate = finalizar

func set_personagem_selecionado(selecionado):
	personagem_selecionado = selecionado

func set_acao_selecionada(selecionada):
	acao_selecionada = selecionada

func set_opcao_selecionada(selecionada):
	opcao_selecionada = selecionada

func _on_timer_timeout():
	rodar_combate()
