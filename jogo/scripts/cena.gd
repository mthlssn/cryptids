extends Node2D

func _ready():
	Jogo.set_node(self)
	Transition.fade_into("res://scenes/demo/demo_cena_1.tscn")
