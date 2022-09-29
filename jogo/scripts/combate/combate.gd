extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureButton.grab_focus()
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$TextureButton2.focus_mode = 0
