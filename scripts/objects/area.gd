extends "objects.gd"

export var function : String = "" 
export var colisao = true
export var apagar = false

func interacao_area():
	if func_interacao:
		if "portal" in self.name:
			var node = get_parent().get_parent().get_node("area/"+self.name)
			if node.tipo_portal == "porta":
				node.colisao(get_parent().get_parent())
				Global.set_mover(false)
