extends Node3D
signal send_to_manager
signal change_interact_ui_visibility_true
signal change_interact_ui_visibility_false
var action_taken
@export var manager:interactable_manager

func _ready() -> void:
	#Only keep the manager if you need it, if the interactable doesn't that you can delete this line.
	send_to_manager.connect(manager.send_to_manager_action_node.bind(self))
	change_interact_ui_visibility_true.connect(manager.interact_ui_visibility_true)
	change_interact_ui_visibility_false.connect(manager.interact_ui_visibility_false)
	
func take_action():
	action_taken = true
#	This is to be filled in when you attach it to an object. It is special per object.

func send():
	#Use this method if you want to go through the manager isntead of keeping it contained with the interactable
	send_to_manager.emit()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if !action_taken:
		if body == Game.player:
			#This commented line is if you want the player to interact and immediatly activate the interactable,
			# if you need to do more with a connection of interatables than send it through the manager instead
			#Game.player.interact_signal.connect(take_action)	
			change_interact_ui_visibility_true.emit()
	
	

func _on_area_3d_body_exited(body: Node3D) -> void:
	if !action_taken:
		if body == Game.player:
			#Game.player.interact_signal.disconnect(take_action)	
			change_interact_ui_visibility_true.emit()
