extends Control

var tamanho_selecionado

func chamar_video():
	tamanho_selecionado = DataPlayer.get_tamanho_tela()
	mostar_setinha()

func fechar():
	$setinha.hide()
	$animation_player.stop()
	DataPlayer.save_configs("tamanho_tela")

func selecionar_tamanho(tamanho):
	match tamanho:
		"tela_inteira":
			tamanho_selecionado["tamanho_tela"] = "tela_inteira"
		"960x576":
			tamanho_selecionado["tamanho_tela"] = "960x576"
		"720x432":
			tamanho_selecionado["tamanho_tela"] = "720x432"
	
	mostar_setinha()
	
	DataPlayer.set_tamanho_tela(tamanho_selecionado)
	DataPlayer.set_tela()

func mostar_setinha():
	$setinha.show()
	
	match tamanho_selecionado["tamanho_tela"]:
		"tela_inteira":
			$setinha.position.y = 184
		"960x576":
			$setinha.position.y = 200
		"720x432":
			$setinha.position.y = 216
	
	$animation_player.play("setinha")
