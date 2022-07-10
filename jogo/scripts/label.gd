extends Node2D

onready var timer = get_node("label/timer")

func mostrar_texto(texto, posicao):
	position = posicao
	timer.start()
	get_node("label").set_text(texto)

func _on_timer_timeout():
	call_deferred("free")
