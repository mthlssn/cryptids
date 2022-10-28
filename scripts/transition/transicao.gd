extends CanvasLayer

onready var _animation = $animation_player
var _scene_to_go = ""

var _node

func set_animando_false():
	self.hide()
	Global.set_mover(true)

# animacao = "fade", "fade_2" e "fade_3"
func fade(node, scene, velocidade, animacao):
	self.show()
	_animation.playback_speed = velocidade
	_node = node
	
	_scene_to_go = scene
	_animation.play(animacao)
	Global.set_mover(false)

func chamar_funcao():
	if _scene_to_go != "":
		get_tree().call_deferred("change_scene", _scene_to_go)
	else:
		_node.func_transicao()
