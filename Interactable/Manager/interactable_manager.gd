extends Node3D
class_name interactable_manager

func send_to_manager_node_reveal(node_to_reveal:PackedScene, location_of_node:Vector2, interactable):
	var node = node_to_reveal.instantiate()
	interactable.add_child(node)
	node.global_position = location_of_node

func interact_ui_visibility_true():
	Game.hud.change_visinbility_true(Game.hud.interactUI)

func interact_ui_visibility_false():
	Game.hud.change_visinbility_false(Game.hud.interactUI)
