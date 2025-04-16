extends Control
class_name HUD
@onready var interactUI = $Interact

func change_visinbility_true(control:Control):
	control.visible = true

func change_visinbility_false(control:Control):
	control.visible = false
