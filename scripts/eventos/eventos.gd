extends Node

var proximo_evento = 1

func chamar_evento():
	match proximo_evento:
		1:
			evento_1()
		
func evento_1():
	Transition.fade(self, "res://scenes/demo/demo.tscn", 1, "fade")
