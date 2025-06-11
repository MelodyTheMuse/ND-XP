extends Node3D
@onready var mesh = $AnimationPlayer/MeshInstance3D
@onready var anime = $AnimationPlayer
var dialogviewer:Control
var dialogreader:DialogueReader
var barista_reader_scene:PackedScene = preload("res://barista_reader.tscn")
var Dialogbox
var timer:Timer


func _on_area_3d_body_entered(body: Node3D) -> void:
	mesh.visible = false
	anime.stop(true)
	find_dialog()
	set_dialog()
	dialog_timer()

func find_dialog():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			Dialogbox = c
			for d in Dialogbox.get_children():
				if d.name == "Dialogviewer":
					dialogviewer = d

func display_dialog_stanger():
	Input.mouse_mode = 3
	dialogviewer.set_dialog_line()
	Dialogbox.visible = true
func set_dialog():
	dialogreader = barista_reader_scene.instantiate()
	dialogviewer.set_reader(dialogreader)

func dialog_timer():
	if timer:
		timer.start(1)
	else:
		timer = Timer.new()
		timer.timeout.connect(display_dialog_stanger)
		timer.one_shot = true
		timer.autostart = true
		timer.wait_time = 1
		add_child(timer)
