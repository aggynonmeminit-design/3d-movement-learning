extends Node
class_name StateMachineSwitch #After Choosing whether to use Swith or Process delete "Switch"

#=====================================================================================================================

var initial_state: StateSwitch = null

var active_state: StateSwitch

#=====================================================================================================================

func _ready() -> void:

	for child_state: StateSwitch in get_children():
		child_state.switch_stateswitch.connect(change_state)
		child_state.process_mode = Node.PROCESS_MODE_DISABLED

	change_state(active_state)

#=====================================================================================================================

func change_state(new_state: StateSwitch) -> void:
	
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
