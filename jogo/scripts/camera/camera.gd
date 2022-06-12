extends Camera2D

onready var _top_left = $Limites/top_left
onready var _bottom_right = $Limites/bottom_right

func _ready():
	limit_top = _top_left.position.y
	limit_left = _top_left.position.x
	limit_bottom = _bottom_right.position.y
	limit_right = _bottom_right.position.x

func get_tamanho_camera_y():
	return limit_top

func mudar_posicao_camera():
	limit_top = _top_left.position.y - 480
	limit_left = _top_left.position.x
	limit_bottom = _bottom_right.position.y - 480
	limit_right = _bottom_right.position.x
