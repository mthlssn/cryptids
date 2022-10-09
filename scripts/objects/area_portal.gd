extends "area.gd"

export var proxima_camera : int = 0

func colisao():
	Global.set_cena_atual(proxima_camera)
	get_parent().get_parent().get_parent().get_node("camera").mudar_camera()
	
