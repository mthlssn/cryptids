extends Node

onready var animation := $animation_player

var animando = false

func _ready():
	Global.set_node_demo(self)
	
	animation.play("iniciar")

func set_animando():
	if animando:
		animando = false
	else:
		animando = true

func set_tirar_mover_false():
	Global.set_mover(true)
