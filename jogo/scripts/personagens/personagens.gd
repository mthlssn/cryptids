extends Node2D

export var nome : String
export(String, FILE) var path_folder_images

export(Array, Resource) var interaction = []

func interacao():
	if interaction:
		DialogBox.call_dialog_box(true, interaction[0].msg_queue, interaction[0].nome, interaction[0].imagens)

