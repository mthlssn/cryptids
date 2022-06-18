extends CanvasLayer

onready var _animation = $AnimationPlayer
var _scene_to_go = ""

var _animando = false

func get_animando():
	return _animando
	
func set_animando_false():
	_animando = false

func fade_into(scene):
	_scene_to_go = scene
	_animando = true
	_animation.play("fade")

func trocar_cena():
	get_tree().call_deferred("change_scene", _scene_to_go)

