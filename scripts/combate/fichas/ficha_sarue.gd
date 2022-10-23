extends Node

var _ficha
var primeira_vez = true

signal sarue_pronto

var imagem_path = "res://assets/personagens/sarue/normal.png"
var posicao = Vector2(145, 46)

var vez_acao = -1
var ordem_acoes = ["arranhar", "arranhar", "arranhar"]

func abrir_ficha():
	_ficha = Ficha.new("Saruê", 2, 4, 3, 8, 3)
	_ficha.gerar_aplicacoes()

func get_ficha():
	return _ficha

func acao_inimigo(personagens):
	print("chamou")
	vez_acao += 1
	
	match ordem_acoes[vez_acao]:
		"arranhar":
			return skill1(get_alvo(personagens))

#arranhar
func skill1(alvo):
	var dano 
	var dano_recebido = 0
	var texto
	
	_ficha.gastar_energia(4)
	
	if int(_ficha.rng.randf_range(1, 100)) <= _ficha.get_atri_apli("crt"):
		dano = _ficha.get_atri_apli("atk") * 2 + 2
		
		dano_recebido = alvo.get_ficha().receber_dano(dano)
		texto = "O gambá avança. " + alvo.get_ficha().get_nome() + " é RETALHADO recebendo " + String(dano_recebido) + " de dano."
	else:
		dano = _ficha.get_atri_apli("atk") + 2
		
		if not alvo.get_ficha().verificar_desvio():
			dano_recebido =  alvo.get_ficha().receber_dano(dano)
			texto = "O gambá avança. " + alvo.get_ficha().get_nome() + " é arranhado e recebe " + String(dano_recebido) + " de dano."
		else:
			texto = "O gambá avança. É inútil."
	
	if dano_recebido != 0 and primeira_vez:
		texto = texto + " " + alvo.get_ficha().get_nome() + " aprendeu ARRANHAR."
		
		var temp = alvo.get_skills_player()
		temp[1] = "Arranhar"
		alvo.set_skills_player(temp) 
		
		primeira_vez = false
	
	emit_signal("sarue_pronto")
	return texto

func get_alvo(personagens):
	var alvo
	alvo = personagens[int(_ficha.rng.randf_range(0, personagens.size() - 1))]
	return alvo
