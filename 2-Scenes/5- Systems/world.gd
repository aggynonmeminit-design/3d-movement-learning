extends Node3D

#===================================================================================================

@export var level_root   : Node3D
@export var entity_root  : Node3D
@export var effect_root  : Node3D

#===================================================================================================

const TEST_LEVEL         = preload("uid://dsuxa8qs5vi1d")

#===================================================================================================
#Void functions


func setup_level(level:= TEST_LEVEL)                                            -> void:

	var level_ins := level.instantiate()

	level_root.get_children().all(queue_free)
	level_root.add_child(level_ins)
#---------------------------------------------------------------------------------------------------

func _ready()                                                                   -> void:
	setup_level(TEST_LEVEL)
