extends Node3D
signal send_to_manager
signal change_interact_ui_visibility_true
signal change_interact_ui_visibility_false
var action_taken
@export var manager:interactable_manager

func _ready() -> void:
	send_to_manager.connect(manager.send_to_manager_action_node(self))
	change_interact_ui_visibility_true.connect(manager.interact_ui_visibility_true)
	change_interact_ui_visibility_false.connect(manager.interact_ui_visibility_false)
	
func take_action():
	action_taken = true
	
