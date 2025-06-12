extends Node3D
@onready var mesh = $AnimationPlayer/MeshInstance3D
@onready var anime = $AnimationPlayer
var dialogviewer:Control
var dialogreader:DialogueReader
var order_reader:DialogueReader
var stranger_reader_scene:PackedScene = preload("res://Stranger_reader.tscn")
var Dialogbox
var timer:Timer
var order_scene:PackedScene = preload("res://pick_up_order.tscn")
@onready var order_mesh = $"../Coffee/AnimationPlayer2/MeshInstance3D"
@onready var order_anime = $"../Coffee/AnimationPlayer2"
@onready var end_area : Area3D = $"../Coffee/Area3D"
@onready var stanger_area:Area3D = $Area3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	stanger_area.set_deferred("monitoring",false)
	mesh.visible = false
	anime.stop(true)
	find_dialog()
	set_dialog()
	dialog_timer(display_dialog_stanger,1)

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
	dialogreader = stranger_reader_scene.instantiate()
	dialogviewer.set_reader(dialogreader)
	dialogreader.end_reached.connect(dialog_timer.bind(collect_coffee,3))
	dialogreader.end_reached.connect(stranger_hide)

func dialog_timer( call:Callable, time:float):
	if timer:
		print("timer_exist_run")
		timer.start(time)
		timer.timeout.connect(call)
	else:
		timer = Timer.new()
		timer.timeout.connect(call)
		timer.one_shot = true
		timer.autostart = true
		timer.wait_time = time
		add_child(timer)
		print("timer_not_exist_run")

func stranger_hide():
	self.hide()

func collect_coffee():
	print("collect_coffee")
	anime.play("WayPoint")
	order_mesh.show()
	order_reader = order_scene.instantiate()
	dialogviewer.set_reader(order_reader)
	dialogviewer.set_dialog_line()
	Input.mouse_mode = 3
	Dialogbox.visible = true
	end_area.monitoring = true
