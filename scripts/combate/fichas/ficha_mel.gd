extends Node

var _ficha

func abrir_ficha():
	_ficha = Ficha.new("Mel", 5, 3, 4, 7, 6)
	_ficha.gerar_aplicacoes()

func get_ficha():
	return _ficha
