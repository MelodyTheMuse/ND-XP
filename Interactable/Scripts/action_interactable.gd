extends Node3D
signal send_to_manager
signal change_interact_ui_visibility_true
signal change_interact_ui_visibility_false
var action_taken
@export var manager:interactable_manager

func _ready() -> void:
	change_interact_ui_visibility_true.connect(manager.interact_ui_visibility_true)
	change_interact_ui_visibility_false.connect(manager.interact_ui_visibility_false)
	
func take_action():
	if !action_taken:
		action_taken = true
		send_to_manager.emit()
		Game.player.interact_signal.disconnect(take_action)
		change_interact_ui_visibility_false.emit()
		print("Action taken")
#	This is to be filled in when you attach it to an object. It is special per object.


func _on_area_3d_body_entered(body: Node3D) -> void:
	if !action_taken:
		if body == Game.player:
			Game.player.interact_signal.connect(take_action)	
			change_interact_ui_visibility_true.emit()
	


func _on_area_3d_body_exited(body: Node3D) -> void:
	if !action_taken:
		if body == Game.player:
			Game.player.interact_signal.disconnect(take_action)
			change_interact_ui_visibility_false.emit()
	
