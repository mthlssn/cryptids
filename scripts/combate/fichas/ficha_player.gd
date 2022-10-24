extends Node

var _ficha

var node_combate

# Observar, Arranharm, Amigos
var skills : Array = ["Observar", "nada", "nada", "nada"]
var skills_desc : Array = ["- Estude seu inimigo.\n\n- 0 energia.", 
"- Um ataque primitivo e instintivo, retalhe-os com suas garras.\n\n- 4 energia.\n\n- corpo-a-corpo.",
"- Socorro.\n\n- 2 energia."]
var skills_alvo : Array = ["inimigo", "inimigo", "aliados"]

func abrir_ficha(combate):
	node_combate = combate
	_ficha = Ficha.new(Global.get_nome_player(), 4, 5, 6, 7, 3)
	_ficha.gerar_aplicacoes()

func usar_skill(num, alvo):
	match num:
		0:
			return skill1(alvo)
		1:
			return skill2(alvo)
		2:
			return skill3(alvo)

#observar
func skill1(alvo):
	var texto

	match alvo.get_ficha().get_nome():
		"Saruê":
			texto = _ficha.get_nome() + " observa o inimigo... Uma criatura frágil mas nem tão indefesa, está tentando se proteger de nós."
	
	node_combate.set_node_vez(null)
	return texto

#arranhar
func skill2(alvo):
	var dano
	var texto
	
	if not _ficha.gastar_energia(4):
		node_combate.set_node_vez(self)
		return "Você está muito cansado(a)."
	
	if int(_ficha.rng.randf_range(1, 100)) <= _ficha.get_atri_apli("crt"):
		dano = _ficha.get_atri_apli("atk") * 2 + 2
		
		var dano_recebido = alvo.get_ficha().receber_dano(dano)
		texto = _ficha.get_nome() + " avança. " + alvo.get_ficha().get_nome() + " é RETALHADO recebendo " + String(dano_recebido) + " de dano."
	else:
		dano = _ficha.get_atri_apli("atk") + 2
		
		if not _ficha.verificar_desvio():
			var dano_recebido =  alvo.get_ficha().receber_dano(dano)
			texto = _ficha.get_nome() + " avança. " + alvo.get_ficha().get_nome() + " é arranhado e recebe " + String(dano_recebido) + " de dano."
		else:
			texto = _ficha.get_nome() + " avança. É inútil."
	
	node_combate.set_node_vez(null)
	return texto

#amigos
func skill3(alvo):
	if not _ficha.gastar_energia(2):
		node_combate.set_node_vez(self)
		return "Você está muito cansado(a)."
	
	node_combate.set_node_vez(alvo)
	return _ficha.get_nome() + " compra tempo para " + alvo.get_ficha().get_nome() + "."

func get_skills_player():
	return skills

func set_skills_player(skill):
	skills = skill

func get_ficha():
	return _ficha