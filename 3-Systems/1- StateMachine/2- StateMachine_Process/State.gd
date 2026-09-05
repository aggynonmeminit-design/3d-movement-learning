extends Node
class_name StateProcess #After Choosing whether to use Swith or Process delete "Process"
#=====================================================================================================================

signal switch_stateprocess(state: StateProcess) #After Choosing whether to use Swith or Process delete "Process"

#=====================================================================================================================

func enter_state() -> void:
	pass
	
func exit_state() -> void:
	pass
	
func update(delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	pass
