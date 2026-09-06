extends Node3D

@export var door_position : Vector3 
@onready var door_csg: CSGBox3D = $WallCSG/DoorCSG
@onready var door: Node3D = $Door
@onready var wall_csg: CSGBox3D = $WallCSG

func set_CSG_size() -> void:
	door_csg.size = Vector3(door.mesh.mesh.size.x, door.mesh.mesh.size.y, wall_csg.size.z * 2)
func set_door_position() -> void:
	door.position = Vector3(door.position.x, door.position.y, (0.5 * wall_csg.size.z - 0.06) * -1)
func set_CSG_position() -> void:
	door_csg.position = door.position

func _physics_process(_delta: float) -> void:
	set_door_position()
	set_CSG_size()
	set_CSG_position()
	
	
