extends Node

const MAX_FRAMES_P1 = 45
const MAX_FRAMES_P2 = 38
const MAX_FRAMES_P3 = 36

const T_TEXTO = 2.5

onready var p1 := $parte1
onready var p2 := $parte2
onready var p3 := $parte3
onready var timer := $timer

var vez_frame = [1,0]
var cont = 0
var t = 0 #tempo

var acabar = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		acabar = true
		
		timer.wait_time = 0.1
		timer.start()

func _ready():
	while acabar == false:
		t = 0.04
		
		match vez_frame:
			[1,0]:
				t = T_TEXTO
			[1,1]:
				t = T_TEXTO
			[1,19]:
				t = T_TEXTO
			[1,20]:
				t = T_TEXTO
			[1,34]:
				t = T_TEXTO
			[1,35]:
				t = T_TEXTO
			[2,0]:
				t = T_TEXTO
			[2,1]:
				t = T_TEXTO
			[2,26]:
				t = 1
			[2,37]:
				t = 1
			[3,0]:
				t = T_TEXTO
			[3,1]:
				t = T_TEXTO
			[3,8]:
				t = T_TEXTO
			[3,9]:
				t = T_TEXTO
			[3,33]:
				t = T_TEXTO
			[3,34]:
				t = T_TEXTO
			[3,35]:
				t = T_TEXTO
		
		cont = cont + t
		timer.wait_time = t
		
		match vez_frame[0]:
			1:
				p1.show()
				p1.frame = vez_frame[1]
				
				if vez_frame[1]+1 == MAX_FRAMES_P1:
					vez_frame[0] = 2
					vez_frame[1] = -1
			2:
				p2.show()
				p2.frame = vez_frame[1]
				
				if vez_frame[1]+1 == MAX_FRAMES_P2:
					vez_frame[0] = 3
					vez_frame[1] = -1
			3:
				p3.show()
				p3.frame = vez_frame[1]
				
				if vez_frame[1]+1 == MAX_FRAMES_P3:
					acabar = true
		
		timer.start()
		yield(timer, "timeout")
		
		vez_frame[1] += 1
	
	print("Duração(s): ", cont)
	Transition.fade(self, "res://scenes/demo/demo.tscn", 2, "fade", false)
