extends Node3D

#===================================================================================================

@export var level_root   : Node3D
@export var entity_root  : Node3D
@export var effect_root  : Node3D

#===================================================================================================

const TEST_LEVEL         = preload("uid://dsuxa8qs5vi1d")
const PLAYER = preload("uid://d1ngulh3pm07m")

#===================================================================================================
#Void functions


func setup_player(player_preload := PLAYER)                                            -> void:
	var player_ins := player_preload.instantiate()
	entity_root.add_child(player_ins)
	player_ins.position.y += 1
#---------------------------------------------------------------------------------------------------

func setup_level(level:= TEST_LEVEL)                                            -> void:
	var level_ins := level.instantiate()
	level_root.get_children().all(queue_free)
	level_root.add_child(level_ins)
#---------------------------------------------------------------------------------------------------

func _ready()                                                                   -> void:
	setup_level(TEST_LEVEL)
	setup_player(PLAYER)
