extends Camera2D

var _limite1_top_left 
var _limite1_bottom_right

func _ready():
	mudar_camera()

func mudar_camera():
	var _node_limites
	
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
			
	_limite1_bottom_right = _node_limites.get_node("bottom_right").position
	_limite1_top_left = _node_limites.get_node("top_left").position
	
	print(self, " ", _limite1_bottom_right)

func set_limites():
	limit_top = _limite1_top_left.position.y
	limit_left = _limite1_top_left.position.x
	limit_bottom = _limite1_bottom_right.position.y
	limit_right = _limite1_bottom_right.position.x
