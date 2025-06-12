extends Node3D
@onready var anime : AnimationPlayer = $AnimationPlayer2
@onready var mesh : MeshInstance3D = $AnimationPlayer2/MeshInstance3D
var dialog_viewer:Control
var dialog_reader:DialogueReader
var end_scene:PackedScene = preload("res://the_end.tscn")
var timer:Timer
var diabox
@onready var area:Area3D = $Area3D

func _on_area_3d_2_body_entered(body: Node3D) -> void:
	area.set_deferred("monitoring",false)
	anime.stop(true)
	mesh.hide()
	find_dialog()
	set_dialog()
	display_dialog_end()

func find_dialog():
	for c in Game.hud.get_children():
		if c.name == "Dialogbox":
			diabox = c
			for d in diabox.get_children():
				if d.name == "Dialogviewer":
					dialog_viewer = d

func display_dialog_end():
	Input.mouse_mode = 3
	dialog_viewer.set_dialog_line()
	diabox.visible = true

func set_dialog():
	dialog_reader = end_scene.instantiate()
	dialog_viewer.set_reader(dialog_reader)
