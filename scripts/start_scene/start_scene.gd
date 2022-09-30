extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("enter"):
		Eventos.chamar_evento()
