extends Node3D
class_name InteractionComponent
#===================================================================================================

@onready var label: Label3D = $Label

#---------------------------------------------------------------------------------------------------

var current_interactions := []
var can_interact := true

#===================================================================================================
#Void Functions

func _on_interaction_range_area_entered(area: Area3D) -> void:
	current_interactions.push_back(area)
func _on_interaction_range_area_exited(area: Area3D) -> void:
	current_interactions.erase(area)
#---------------------------------------------------------------------------------------------------

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Interact") and can_interact:
		if current_interactions:
			can_interact = false
			label.hide()

			await current_interactions[0].interact.call()
			can_interact = true

#---------------------------------------------------------------------------------------------------

func _physics_process(_delta: float) -> void:
	if current_interactions and can_interact:
		current_interactions.sort_custom(sort_by_nearest)
		if current_interactions[0].is_interactable:
			label.text = current_interactions[0].interact_name
			label.show()
	else: 
		label.hide()

#===================================================================================================
#Return functions

func sort_by_nearest(area1 : Node3D, area2: Node3D) -> bool:
	var area1_distance := global_position.distance_to(area1.global_position)
	var area2_distance := global_position.distance_to(area2.global_position)
	return area1_distance < area2_distance
