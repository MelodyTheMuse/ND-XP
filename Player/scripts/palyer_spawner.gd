extends Node
var player_scene:PackedScene = preload("res://Player/prefab/PlayerPrefab.tscn")
var player

func _ready():
	if(player == null):
		player = player_scene.instantiate()
		get_tree().current_scene.add_child.call_deferred(player)
		Game.player = player
