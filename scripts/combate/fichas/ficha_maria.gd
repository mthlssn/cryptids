extends Node

var _ficha

func abrir_ficha():
	_ficha = Ficha.new("Maria", 3, 6, 7, 4, 5)
	_ficha.gerar_aplicacoes()

func get_ficha():
	return _ficha
