extends Node
class_name StateMachineProcess #After Choosing whether to use Swith or Process delete "Process" 

#=====================================================================================================================

var initial_state: StateProcess = null #After Choosing whether to use Swith or Process delete "Process"

var active_state: StateProcess

#=====================================================================================================================

func _ready() -> void:

	for child_state: StateProcess in get_children():
		child_state.switch_stateprocess.connect(change_state)
		child_state.process_mode = Node.PROCESS_MODE_DISABLED

	change_state(active_state)

#=====================================================================================================================

func change_state(new_state: StateProcess) -> void:
	
	if new_state == active_state:
		return

	if active_state:
		active_state.exit_state()
		active_state.process_mode = Node.PROCESS_MODE_DISABLED
	active_state = new_state

	if active_state:
		active_state.enter_state()
		active_state.process_mode = Node.PROCESS_MODE_INHERIT
	print(active_state)
