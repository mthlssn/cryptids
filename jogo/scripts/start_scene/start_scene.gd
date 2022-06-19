extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("enter"):
		Transition.fade_into("res://scenes/demo/demo_cena_1.tscn")
