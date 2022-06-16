extends Camera2D

onready var _top_left = $limites/top_left
onready var _bottom_right = $limites/bottom_right

func _ready():
	limit_top = _top_left.position.y
	limit_left = _top_left.position.x
	limit_bottom = _bottom_right.position.y
	limit_right = _bottom_right.position.x

func get_limite_cam():
	return [limit_left, limit_right, limit_top, limit_bottom]
