class_name Ficha
extends Node

var rng = RandomNumberGenerator.new()

var _nome : String

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
	
	rng.randomize()

func gastar_energia(valor):
	_eng = _eng - valor

func regenerar_energia():
	_eng = _eng + _con

func verificar_desvio():
	if int(rng.randf_range(1, 100)) <= _dge:
		return true
	else:
		return false

func receber_dano(dano):
	dano = dano - ( dano * (_res / 100.0))
	
	var temp = dano - floor(dano)
	if temp <= 0.5:
		dano = floor(dano)
	else:
		dano = floor(dano) + 1
		
	_hp = _hp - dano
	
	return dano #dano recebido

func get_all():
	return[_atk, _def, _con, _spd, _des, _hp, _eng, _crt, _dge, _res]

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
