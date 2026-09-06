extends Node3D
class_name Interactable_Object
#===================================================================================================

@export var interact_name: String = ""
@export var is_interactable: bool = true

var interact: Callable = func() -> void:
	pass
