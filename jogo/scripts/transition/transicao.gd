extends CanvasLayer

onready var animation = $AnimationPlayer
var scene_to_go = ""

func fade_into(scene):
	scene_to_go = scene
	animation.play("fade")

func chamar_trocar_cena():
	Jogo.trocar_cena(scene_to_go)
	#get_tree().change_scene(scene_to_go)
