extends Node3D

@onready var interactable: Interactable_Object = $Pivot/Interactable
@onready var pivot: Node3D = $Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	interactable.interact = on_interact
		
func on_interact() -> void:
	if pivot.rotation.y == 0:
		animation_player.play("Props/Open Door")
	elif pivot.rotation.y != 0:
		animation_player.play("Props/Close Door")
		
		
		
