extends Node

var _ficha

# Observar, Arranharm, Amigos
var skills : Array = ["Observar", "nada", "nada", "nada"]
var skills_desc : Array = ["- Estude seu inimigo...\n\n- 0 energia.", 
"- Um ataque primitivo e instintivo, retalhe-os com suas garras.\n\n- 4 energia.\n\n- corpo-a-corpo.",
"- Socorro.\n\b- 2 energia."]
var skills_alvo : Array = ["inimigo", "inimigo", "aliados", "inimigos"]

var itens : Array = ["Desenho", "nada", "nada", "nada"]
var itens_desc : Array = ["- Desenho da Maria.\n\n- Um desenho.\n\n- só q da Maria."]

func abrir_ficha():
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
	
	return texto

#arranhar
func skill2(alvo):
	var dano
	var texto
	
	_ficha.gastar_energia(4)
	
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
	
	return texto

#amigos
func skill3(alvo):
	var texto
	_ficha.gastar_energia(2)
	
	texto = "n entendi ;-;"
	return texto

func get_skills_player():
	return skills

func set_skills_player(skill):
	skills = skill

func get_ficha():
	return _ficha
