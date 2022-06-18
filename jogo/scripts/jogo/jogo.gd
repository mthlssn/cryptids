extends Node2D

var _ultima_cena

func _ready():
	var next_cena_resource = load("res://scenes/demo/demo_cena_1.tscn")
	var teste = next_cena_resource.instance()
	add_child(teste)
	
	_ultima_cena = "res://scenes/demo/demo_cena_1.tscn"

func trocar_cena(caminho_cena):
	remove_child(load(_ultima_cena).self)
	load(_ultima_cena).self.call_deferred("free")

	var next_cena_resource = load(caminho_cena)
	var teste = next_cena_resource.instance()
	add_child(teste)
	
	_ultima_cena = caminho_cena
