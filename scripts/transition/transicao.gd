extends CanvasLayer

onready var _animation = $animation_player
var _scene_to_go = ""

var _node

var _animando = false

func get_animando():
	return _animando
	
func set_animando_false():
	_animando = false

# animacao = "fade" ou "fade_2"
func fade(node, scene, velocidade, animacao):
	_animation.playback_speed = velocidade
	_node = node
	
	_scene_to_go = scene
	_animation.play(animacao)
	_animando = true

func chamar_funcao():
	if _scene_to_go != "":
		get_tree().call_deferred("change_scene", _scene_to_go)
	else:
		_node.func_transicao()
