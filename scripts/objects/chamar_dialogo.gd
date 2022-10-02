extends "objects.gd"

export var personagem = true

func colisao():
	if personagem:
		DialogBox.call_dialog_box(true, dialogo_resource.msg_queue, dialogo_resource.nome, dialogo_resource.imagens)
	else:
		DialogBox.call_dialog_box(false, dialogo_resource.msg_queue, null, null)
