extends Node3D
var label:RichTextLabel
var x = 1
var text 
var Dialogbox

func start_interview():
	find_dialog_label()
	Game.player.dialog_signal.connect(raise_x)
	choose_dialog_interview()
	display_dialog_interview()

func find_dialog_label():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			Dialogbox = c
			label = c.get_child(0)

func choose_dialog_interview():
	match x:
		1:
			text = "Good day to you"
		2: 
			text= "Shall we begin?"
		3:
			text = "I have read through your CV, and I have to say it is pretty good"
		4:
			text = "There is a few things that we have to go through however, before we can start the rest of the hiring process"
	display_dialog_interview()

func display_dialog_interview():
	Dialogbox.visible = true
	label.text = text

func raise_x():
	x +=1
	choose_dialog_interview()
