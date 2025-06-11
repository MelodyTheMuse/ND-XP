extends Node3D
var label:RichTextLabel
var x = 1
var text 
var Dialogbox
var dialogviewer:Control
var dialogreader:DialogueReader
var barista_reader_scene:PackedScene = preload("res://barista_reader.tscn")
@onready var animation:AnimationPlayer = $"../Stranger/AnimationPlayer"
@onready var mesh = $"../Stranger/AnimationPlayer/MeshInstance3D"

@export var dialog_text:GraphData

func start_interview():
	Input.mouse_mode = 3
	find_dialog()
	set_dialog()
	display_dialog_interview()

func find_dialog():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			Dialogbox = c
			for d in Dialogbox.get_children():
				if d.name == "Dialogviewer":
					dialogviewer = d

func display_dialog_interview():
	Dialogbox.visible = true
func set_dialog():
	dialogreader = barista_reader_scene.instantiate()
	dialogviewer.set_reader(dialogreader)
	dialogreader.end_reached.connect(start_animation)

func start_animation():
	mesh.visible = true
	animation.play("Way_point")
	
