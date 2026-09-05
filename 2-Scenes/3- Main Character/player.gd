extends CharacterBody3D
class_name Player

#===================================================================================================
#Variables

@onready var cameraNeck    : Node3D      = $CameraNeck
@onready var camera        : Camera3D    = $CameraNeck/Camera

#---------------------------------------------------------------------------------------------------

@export var camera_sens := Vector2(0.7, 0.8)
@export var walk_speed  := 5.0
@export var run_factor  := 2.0
@export var jump_factor := 3.0
var jump_charge         := 0.0
var speed_factor        := 1.0

#===================================================================================================
#Void functions


func change_mouse_capture(event: InputEvent)                                    -> void:
	
	if event is InputEventMouseButton:
		#Despausar
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("Pause"):
		#Pausar
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#---------------------------------------------------------------------------------------------------
func fall(delta: float)                                                         -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		speed_factor = 0.8
	else:
		speed_factor = 1.0
#---------------------------------------------------------------------------------------------------
func jump()                                                                     -> void:
	if Input.is_action_pressed("Jump") and is_on_floor():
		jump_charge = clamp(jump_charge + 0.1, 0.1, 3) 
		speed_factor = 0.5
	elif Input.is_action_just_released("Jump") and is_on_floor():
		velocity.y = jump_factor * jump_charge
		jump_charge = 0.0
		speed_factor = 1.0
#---------------------------------------------------------------------------------------------------
func _unhandled_input(event: InputEvent)                                        -> void:
	change_mouse_capture(event) 
#---------------------------------------------------------------------------------------------------
func camera_update(event: InputEvent)                                           -> void:
	
	rotation.y -= event.relative.x * 0.005 * camera_sens.x
	cameraNeck.rotation.x = clamp(cameraNeck.rotation.x - event.relative.y * 0.005 * camera_sens.y, -1.4, 1.4)
		

func _physics_process(delta: float)                                             -> void:
	#Jump and fall
	fall(delta)
	jump()

	#Walk
	var input_dir := Input.get_vector("Walk_Left", "Walk_Right", "Walk_Forward", "Walk_Backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed()
		velocity.z = direction.z * speed()
	else:
		velocity.x = move_toward(velocity.x, 0, speed())
		velocity.z = move_toward(velocity.z, 0, speed())

	move_and_slide()

func _input(event: InputEvent)                                                  -> void: 
	if event is InputEventMouseMotion:
		camera_update(event)
	
#===================================================================================================
#Return functions 

func speed()                                                                    -> float:
	if Input.is_action_pressed("Sprint"):
		return speed_factor * run_factor * walk_speed
	else:
		return speed_factor * walk_speed 
#yay
