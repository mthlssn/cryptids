extends Node

var _ficha
var node_combate

# Motivar
var skills : Array = ["Motivar", "nada", "nada", "nada"]
var skills_desc : Array = ["- Maria enche um aliado de coragem com suas palavras de apoio.\n\n- Reduz o medo, e fraquezas.\n\n- 4 energia."]
var skills_alvo : Array = ["aliados"]

func abrir_ficha(combate):
	node_combate = combate
	_ficha = Ficha.new("Maria", 3, 6, 7, 4, 5)
	_ficha.gerar_aplicacoes()

func usar_skill(num, alvo):
	match num:
		0:
			return skill1(alvo)

#motivar
func skill1(alvo):
	if not _ficha.gastar_energia(4):
		node_combate.set_node_vez(self)
		return "Você está muito cansado(a)."
	
	var eng_regenerada = alvo.get_ficha().get_atri_apli("eng")
	alvo.get_ficha().regenerar_energia("con")
	eng_regenerada = alvo.get_ficha().get_atri_apli("eng") - eng_regenerada
	
	node_combate.set_node_vez(null)
	return alvo.get_ficha().get_nome() + " se sente um pouco melhor. " + alvo.get_ficha().get_nome() + " recupera " + String(eng_regenerada) + " de energia."

func get_ficha():
	return _ficha
