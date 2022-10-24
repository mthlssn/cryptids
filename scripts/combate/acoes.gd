extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_botao_focus_entered(extra_arg_0):
	match extra_arg_0:
		"agir":
			$agir/icon.texture = load("res://assets/combate/agir.png")
		"pular":
			$pular/icon.texture = load("res://assets/combate/pular.png")
		"itens":
			$itens/icon.texture = load("res://assets/combate/itens.png")
		"fugir":
			$fugir/icon.texture = load("res://assets/combate/fugir.png")

func _on_botao_focus_exited(extra_arg_0):
	match extra_arg_0:
		"agir":
			$agir/icon.texture = load("res://assets/combate/agir_s_cor.png")
		"pular":
			$pular/icon.texture = load("res://assets/combate/pular_s_cor.png")
		"itens":
			$itens/icon.texture = load("res://assets/combate/itens_s_cor.png")
		"fugir":
			$fugir/icon.texture = load("res://assets/combate/fugir_s_cor.png")
