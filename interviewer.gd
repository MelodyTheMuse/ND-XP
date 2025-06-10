extends Node3D
var label:RichTextLabel
var x = 1
var text 
var Dialogbox

func start_interview():
	Input.mouse_mode = 3
	find_dialog()
	display_dialog_interview()

func find_dialog():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			Dialogbox = c
			

func display_dialog_interview():
	Dialogbox.visible = true
