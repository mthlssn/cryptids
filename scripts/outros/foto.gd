extends CanvasLayer

onready var foto_frente = preload("res://assets/outros/foto_frente.png")
onready var foto_verso = preload("res://assets/outros/foto_verso.png")

func _ready():
	Global.set_mover(false)
	Global.set_pausar(false)
	
	_on_sete_esquerda_pressed()
	
	$animation_player.play("abri_foto")

func _on_sete_esquerda_pressed():
	$botoes/sete_direita.focus_mode = 2
	$botoes/sete_direita.disabled = false
	
	$imagem.texture = foto_frente
	
	$botoes/sete_esquerda.focus_mode = 0
	$botoes/sete_esquerda.disabled = true
	$botoes/sete_direita.grab_focus()

func _on_sete_direita_pressed():
	$botoes/sete_esquerda.focus_mode = 2
	$botoes/sete_esquerda.disabled = false
	
	$imagem.texture = foto_verso
	
	$botoes/sete_direita.focus_mode = 0
	$botoes/sete_direita.disabled = true
	$botoes/sete_esquerda.grab_focus()


func _on_fechar_pressed():
	$animation_player.play("fechar_foto")
	yield($animation_player, "animation_finished")
	
	Global.set_mover(true)
	Global.set_pausar(true)
	get_node("../tilemap/fogueira1").dg_interacao = false
	queue_free()
