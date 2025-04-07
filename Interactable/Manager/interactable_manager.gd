extends Node3D
class_name interactable_manager

func send_to_manager_node_reveal(node_to_reveal:PackedScene, location_of_node:Vector2, interactable):
	var node = node_to_reveal.instantiate()
	interactable.add_child(node)
	node.global_position = location_of_node

func send_to_manager_action_node(node:Node3D):
	node.take_action()
