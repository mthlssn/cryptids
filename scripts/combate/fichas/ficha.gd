class_name Ficha
extends Node

var rng = RandomNumberGenerator.new()

var _nome : String

var _valores_iniciais : Array

#status
var _atk : int
var _def : int
var _con : int
var _spd : int
var _des : int

#aplicações
var _hp : int
var _eng : int
var _crt : int
var _dge : int
var _res : int

var _morto : bool = false

#construtor
func _init(nome, atk, def, con, spd, des):
	_nome = nome
	_atk = atk
	_def = def
	_con = con
	_spd = spd
	_des = des

func gerar_aplicacoes():
	_hp = 10 + _def + _con - _spd
	_eng = 2 * _spd + _con - _def
	_crt = 3 * _des
	_dge = 2 * _spd + _def
	_res = 3 * _def
	
	_valores_iniciais = get_all()
	
	rng.randomize()

func atualizar_aplicacoes():
	_crt = 3 * _des
	_dge = 2 * _spd + _def
	_res = 3 * _def

func gastar_energia(valor):
	if (_eng - valor) < 0:
		return false
	else:
		_eng = _eng - valor
		return true

func regenerar_energia(quantidade):
	match quantidade:
		"toda":
			_eng = _valores_iniciais[6]
		"con":
			if _valores_iniciais[6] <= (_eng + _con):
				_eng = _valores_iniciais[6]
			else:
				_eng = _eng + _con

func verificar_desvio():
	if int(rng.randf_range(1, 100)) <= _dge:
		return true
	else:
		return false

func calcular_resistencia(dano):
	dano = dano - ( dano * (_res / 100.0))
	
	var temp = dano - floor(dano)
	if temp <= 0.5:
		dano = floor(dano)
	else:
		dano = floor(dano) + 1
	
	return dano #dano_recebido

func receber_dano(dano):
	_hp = _hp - dano
	
	if _hp < 0:
		_hp = 0

func receber_aume_hp(hp):
	_hp = _hp + hp
	
	if _valores_iniciais[5] < _hp:
		_hp = _valores_iniciais[5]

func receber_aume_def(def):
	_def = _def + def
	
	if _valores_iniciais[1] < _def:
		_def = _valores_iniciais[1]

func receber_aume_eng(eng):
	_eng = _eng + eng
	
	if _valores_iniciais[6] < _eng:
		_eng = _valores_iniciais[6]

func receber_aume_spd(spd):
	_spd = _spd + spd
	
	if _valores_iniciais[3] < _spd:
		_spd = _valores_iniciais[3]

func receber_redu_eng(eng):
	_eng = _eng - eng
	
	if _eng < 0:
		_eng = 0

func receber_redu_spd(spd):
	_spd = _spd - spd
	
	if _spd < 1:
		_spd = 1

func receber_redu_res(res):
	_res = _res - res
	
	if _res < 0:
		_res = 0

func receber_roubo_eng(eng):
	var temp = _eng
	receber_redu_eng(eng)
	return temp - _eng #energia roubada

func receber_roubo_spd(spd):
	var temp = _spd
	receber_redu_spd(spd)
	return temp - _spd #speed roubada

func set_morto(morto):
	_morto = morto

func get_all():
	return[_atk, _def, _con, _spd, _des, _hp, _eng, _crt, _dge, _res]

func get_valores_iniciais():
	return _valores_iniciais

func get_morto():
	return _morto

func get_nome():
	return _nome

func get_atri_apli(atri_apli):
	match atri_apli:
		"atk":
			return _atk
		"def":
			return _def
		"con":
			return _con
		"spd":
			return _spd
		"des":
			return _des
		"hp":
			return _hp
		"eng":
			return _eng
		"crt":
			return _crt
		"dge":
			return _dge
		"res":
			return _res
