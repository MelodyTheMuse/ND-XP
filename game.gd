extends Node
var hud_scene:PackedScene = preload("res://hud.tscn")
var hud:HUD
var player

func _ready():
	if(hud == null):
		hud = hud_scene.instantiate()
		get_tree().current_scene.add_child(hud)
