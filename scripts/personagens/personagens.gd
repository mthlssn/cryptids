extends Node2D

export(Array, Resource) var interaction : Array

func interacao():
	if interaction:
		DialogBox.call_dialog_box(true, interaction[0].msg_queue, interaction[0].nome, interaction[0].imagens)
