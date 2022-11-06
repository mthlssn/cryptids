extends Node

var _ficha
var node_combate

var medo

# Intimidar
var skills : Array = ["Intimidar", "nada", "nada", "nada"]
var skills_desc : Array = ["- Biscoito late e hostiliza um inimigo, reduzindo sua velocidade, e precisão no próximo ataque.\n\n- 3 energia."]
var skills_alvo : Array = ["inimigo"]

func abrir_ficha(combate):
	node_combate = combate
	_ficha = Ficha.new("Biscoito", 5, 3, 4, 7, 6)
	_ficha.gerar_aplicacoes()

func usar_skill(num, alvo):
	match num:
		0:
			return skill1(alvo)

#motivar
func skill1(alvo):
	if not _ficha.gastar_energia(3):
		node_combate.set_node_vez(self)
		return ["Você está muito cansado(a)."]
	
	alvo.get_ficha().receber_redu_spd(3)
	
	node_combate.set_node_vez(null)
	return ["Biscoito late sem parar. ", "###debuff_inimigo", alvo.get_ficha().get_nome() + " parece hesitar."]

func get_ficha():
	return _ficha
