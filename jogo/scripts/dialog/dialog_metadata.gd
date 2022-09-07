extends Resource
class_name DialogMetadata

export(String) var nome
export(Array, String) var msg_queue : Array
export(Array, String, "normal", "triste", "feliz") var reacoes : Array = ["normal"]
export(Array, int) var mostrar_depois : Array = []
