extends Camera2D

func _ready():
	mudar_camera()

func mudar_camera():
	var _node_limites
	
	var _limite_top_left 
	var _limite_bottom_right
	
	match Global.get_cena_atual():
		1:
			_node_limites = get_node("limites1")
		2:
			_node_limites = get_node("limites2")
		3:
			_node_limites = get_node("limites3")
		4:
			_node_limites = get_node("limites4")
		5:
			_node_limites = get_node("limites5")
		6:
			_node_limites = get_node("limites6")
		
	_limite_bottom_right = _node_limites.get_node("bottom_right").position
	_limite_top_left = _node_limites.get_node("top_left").position
	
	offset = Vector2(0, 0)
	
	zoom = Vector2(1,1)
	
	limit_top = _limite_top_left.y
	limit_left = _limite_top_left.x
	limit_bottom = _limite_bottom_right.y
	limit_right = _limite_bottom_right.x
