extends CharacterBody3D
@export var speed = 25
@export var jump_height = 10
@export var LOOKAROUND_SPEED = 0.1
@export var mouse_sensitivity = 0.1
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1
@export_range(10, 400, 1) var acceleration: float = 100 # m/s^2
@onready var neck := $neck
@onready var camera:= $neck/Camera3D
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var forwards
var backwards
var left
var right
var jump
var look_dir
var move_dir
var walk_vel:Vector3

func _physics_process(delta):
	
	velocity.y -= gravity * delta
	_walk()
	get_inputs()
	move_and_slide()
	

func get_inputs():
	forwards = Input.is_action_pressed("Move_Forward")
	backwards = Input.is_action_pressed("Move_Backwards")
	left = Input.is_action_pressed("Move_Left")
	right = Input.is_action_pressed("Move_Right")
	jump = Input.is_action_pressed("Jump")

func _walk() :
	move_dir = Input.get_vector("Move_Left", "Move_Right", "Move_Forward", "Move_Backwards")
	if is_on_floor() && jump:
		velocity.y = jump_height
	var walk_dir = (neck.transform.basis * Vector3(move_dir.x,0,move_dir.y)).normalized()
	if walk_dir:
		velocity.x = walk_dir.x * speed
		velocity.z = walk_dir.z*speed
	else:
		velocity.x = move_toward(velocity.x,0,speed)
		velocity.z = move_toward(velocity.z,0,speed)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	var sens_mod = 1.0
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.01
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			neck.rotate_y(-event.relative.x*0.01)
			camera.rotate_x(-event.relative.y*0.01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30),deg_to_rad(60))
				
				
