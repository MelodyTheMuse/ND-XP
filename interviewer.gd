extends Node3D
var label:Label
var x = 1
var text 

func start_interview():
	find_dialog_label()
	Game.player.dialog_signal.connect(raise_x)
	choose_dialog_interview()
	display_dialog_interview()

func find_dialog_label():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			label = c.get_child(0)

func choose_dialog_interview():
	match x:
		1:
			text = "Good day to you"
		2: 
			text= "Shall we begin?"
	display_dialog_interview()

func display_dialog_interview():
	label.text = text

func raise_x():
	x +=1
	choose_dialog_interview()
