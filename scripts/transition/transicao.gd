extends CanvasLayer

onready var _animation = $AnimationPlayer
var _scene_to_go = ""

var _node

func set_animando_false():
	Global.set_mover(true)

func fade(node, scene, velocidade):
	_animation.playback_speed = velocidade
	_node = node
	
	_scene_to_go = scene
	_animation.play("fade")
	Global.set_mover(false)

func chamar_funcao():
	if _scene_to_go != "":
		get_tree().call_deferred("change_scene", _scene_to_go)
	else:
		_node.func_transicao()
