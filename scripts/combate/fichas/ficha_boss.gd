extends Node

var _ficha
var primeira_vez = true

var node_combate

var _fala = [">!)@#-!& avança da porta"]

var acoes = ["chamado_do_vazio", "observar", "exaurir", "pronunciar"]

func abrir_ficha(combate):
	node_combate = combate
	_ficha = Ficha.new(">!)@#-!&", 6, 10, 13, 16, 5)
	_ficha.gerar_aplicacoes()

func get_ficha():
	return _ficha

func acao_inimigo(personagens):
	if _ficha.get_atri_apli("hp") < 7:
		node_combate.set_combate_finalizado(true)
		return ["O gambá escapou."]
	
	var skill = decidir_skill()
	#var skill = "chamado_do_vazio"
	
	match skill:
		"chamado_do_vazio":
			return skill1(get_alvo(personagens))
		"observar":
			return skill2(get_alvo(personagens))
		"exaurir":
			return skill3()
		"pronunciar":
			return skill4()

#chamado_do_vazio
func skill1(alvo):
	var texto = [
		"A ????????? irá ???????? a todos.",
		alvo.get_ficha().get_nome() + " está com medo.",
		"###debuff_" + get_per(alvo),
		alvo.get_ficha().get_nome() + " está com dificuldades para se mexer."]
	
	_ficha.gastar_energia(0) #era pra ser 7
	
	alvo.get_ficha().receber_redu_eng(4)
	alvo.get_ficha().receber_redu_spd(2)
	
	node_combate.medos[get_per_int(alvo)] += 1
	
	if node_combate.medos[get_per_int(alvo)] > 3:
		node_combate.medos[get_per_int(alvo)] = 3
	
	node_combate.set_node_vez(null)
	return texto

#observar
func skill2(alvo):
	var texto = ["????? ???????? encara o âmago de " + alvo.get_ficha().get_nome() + ".", 
	"###debuff_" + get_per(alvo),
	alvo.get_ficha().get_nome() + " está vulnerável."]
	
	_ficha.gastar_energia(0) #era pra ser 5
	
	alvo.get_ficha().receber_redu_res(2)
	
	node_combate.medos[get_per_int(alvo)] += 1
	
	if node_combate.medos[get_per_int(alvo)] > 3:
		node_combate.medos[get_per_int(alvo)] = 3
	
	node_combate.set_node_vez(null)
	return texto

#exaurir
func skill3():
	var texto = ["????? ???????? ?????? o ambiente.", 
	"Todos se sentem pesados.",
	"###debuff_todos_aliados",
	"Todos se sentem cansados."]
	
	_ficha.gastar_energia(0) #era pra ser 7
	
	var personagens = node_combate.personagens.duplicate()
	var medos = node_combate.medos.duplicate()
	
	var eng_roubada = 0
	var spd_roubada = 0
	
	for i in personagens.size() - 1:
		medos[i] += 1
	
		if medos[i] > 3:
			medos[i] = 3
		
		eng_roubada = eng_roubada + personagens[i].get_ficha().receber_roubo_eng(2 * medos[i])
		spd_roubada = spd_roubada + personagens[i].get_ficha().receber_roubo_spd(1 * medos[i])
	
	node_combate.medos = medos.duplicate()
	
	_ficha.receber_aume_eng(eng_roubada)
	_ficha.receber_aume_spd(spd_roubada)
	
	node_combate.set_node_vez(null)
	return texto

#pronunciar
func skill4():
	var texto
	
	_ficha.gastar_energia(0) #era pra ser 5
	
	var personagens = node_combate.personagens.duplicate()
	var medos = node_combate.medos.duplicate()
	
	# player, maria, biscoito
	var danos = [-1, -1, -1]
	
	for i in personagens.size() - 1:
		var dano = (_ficha.get_atri_apli("atk") / 2) * medos[i]
		
		danos[i] = personagens[i].get_ficha().calcular_resistencia(dano)
		
		danos[i] = personagens[i].get_ficha().get_atri_apli("hp")
		personagens[i].get_ficha().receber_dano(danos[i])
		danos[i] = danos[i] - personagens[i].get_ficha().get_atri_apli("hp")
	
	if personagens.size() > 2:
		texto = [
			"????? ???????? revela ???????? impronunciáveis.",
			"Todos sentem sua mente borbulhar.",
			"###dano_todos_aliados",
			Global.get_nome_player() + " " + String(danos[0]) + " de dano, Maria " + String(danos[1]) + " de dano, Biscoito " + String(danos[2]) + " de dano."]
	else:
		texto = [
			"????? ???????? revela ???????? impronunciáveis.",
			"Todos sentem sua mente borbulhar.",
			"###dano_todos_aliados",
			Global.get_nome_player() + " " + String(danos[0]) + " de dano."]
	
	node_combate.set_personagem_apertado("player")
	node_combate.set_node_vez(null)
	return texto

func decidir_skill():
	var medos = node_combate.medos.duplicate()
	
	var total = 0
	for i in medos.size():
		total = total + medos[i]
	
	if total < 3:
		return acoes[int(_ficha.rng.randf_range(0, 2))]
	else: 
		return acoes[int(_ficha.rng.randf_range(0, 4))]

func get_fala():
	return _fala

func get_alvo(personagens):
	return personagens[int(_ficha.rng.randf_range(0, personagens.size()))]

func get_per(alvo):
	var temp = alvo.get_ficha().get_nome()
	
	if temp == Global.get_nome_player():
		return "player"
	elif temp == "Maria":
		return "maria"
	elif temp == "Biscoito":
		return "biscoito"

func get_per_int(alvo):
	var temp = alvo.get_ficha().get_nome()
	
	if temp == Global.get_nome_player():
		return 0
	elif temp == "Maria":
		return 1
	elif temp == "Biscoito":
		return 2
