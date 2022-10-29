extends CanvasLayer

onready var _animation = $animation_player
var _scene_to_go = ""

var _node

var _tirar_mover_pause = true

func set_animando_false():
	self.hide()
	
	if _tirar_mover_pause:
		Global.set_mover(true)

# animacao = "fade" e "fade_2"
func fade(node, scene, velocidade, animacao, tirar_mover_pause):
	self.show()
	_animation.playback_speed = velocidade
	_node = node
	_tirar_mover_pause = tirar_mover_pause
	
	_scene_to_go = scene
	_animation.play(animacao)
	Global.set_mover(false)

func chamar_funcao():
	if _scene_to_go != "":
		get_tree().call_deferred("change_scene", _scene_to_go)
	else:
		_node.func_transicao()
