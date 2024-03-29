extends Node

var _ficha
var primeira_vez = true

var node_combate

var _fala = ["Uma criatura avança do meio das folhas."]

var imagem_path = "res://assets/personagens/gamba/normal.png"
var posicao = Vector2(145, 60)

var vez_acao = -1
var ordem_acoes = ["arranhar", "arranhar", "arranhar", "fugir"]

func abrir_ficha(combate):
	node_combate = combate
	_ficha = Ficha.new("Gambá", 2, 4, 4, 8, 2)
	_ficha.gerar_aplicacoes()

func get_ficha():
	return _ficha

func acao_inimigo(personagens):
	if _ficha.get_atri_apli("hp") < 7:
		node_combate.set_combate_finalizado(true)
		return ["O gambá escapou."]
	
	vez_acao += 1
	
	match ordem_acoes[vez_acao]:
		"arranhar":
			return skill1(get_alvo(personagens))
		"fugir":
			node_combate.set_combate_finalizado(true)
			return ["O gambá escapou."]

#arranhar
func skill1(alvo):
	var dano 
	var dano_recebido = 0
	var texto
	
	_ficha.gastar_energia(4)
	
	if int(_ficha.rng.randf_range(1, 100)) <= _ficha.get_atri_apli("crt"):
		dano = _ficha.get_atri_apli("atk") * 2 + 2
		
		dano_recebido = alvo.get_ficha().calcular_resistencia(dano)
		alvo.get_ficha().receber_dano(dano_recebido)
		texto = ["O gambá avança.", "###dano_player" ,alvo.get_ficha().get_nome() + " é RETALHADO(A) recebendo " + String(dano_recebido) + " de dano."]
	else:
		dano = _ficha.get_atri_apli("atk") + 2
		
		if not alvo.get_ficha().verificar_desvio():
			dano_recebido = alvo.get_ficha().calcular_resistencia(dano)
			alvo.get_ficha().receber_dano(dano_recebido)
			texto = ["O gambá avança. ", "###dano_player", alvo.get_ficha().get_nome() + " é arranhado(a) e recebe " + String(dano_recebido) + " de dano."]
		else:
			texto = ["O gambá avança", "É inútil."]
	
	if dano_recebido != 0 and primeira_vez and alvo.get_ficha().get_nome() == Global.get_nome_player():
		texto.resize(texto.size()+1)
		texto[texto.size()-1] = alvo.get_ficha().get_nome() + " aprendeu ARRANHAR."
		
		var temp = alvo.get_skills_player()
		temp[1] = "Arranhar"
		alvo.set_skills_player(temp) 
		
		primeira_vez = false
		
	node_combate.set_node_vez(null)
	return texto

func get_fala():
	return _fala

func get_alvo(personagens):
	return personagens[int(_ficha.rng.randf_range(0, personagens.size() -1))]
