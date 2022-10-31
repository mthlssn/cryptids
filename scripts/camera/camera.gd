extends Camera2D

func _ready():
	if Global.get_cena_atual() >= 7:
		mudar_camera(true)
	else: 
		mudar_camera(false)

func mudar_camera(casa):
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
		7:
			_node_limites = get_node("limites7")
		8:
			_node_limites = get_node("limites8")
		9:
			_node_limites = get_node("limites9")
		
	_limite_bottom_right = _node_limites.get_node("bottom_right").position
	_limite_top_left = _node_limites.get_node("top_left").position
	
	offset = Vector2(0, 0)
	
	if casa:
		zoom = Vector2(0.8, 0.8)
	else:
		zoom = Vector2(1,1)
	
	limit_top = _limite_top_left.y
	limit_left = _limite_top_left.x
	limit_bottom = _limite_bottom_right.y
	limit_right = _limite_bottom_right.x
