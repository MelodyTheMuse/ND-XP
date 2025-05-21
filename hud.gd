extends CanvasLayer
class_name HUD
@onready var interactUI = $Interact

func change_visinbility_true(control):
	control.visible = true

func change_visinbility_false(control):
	control.visible = false
