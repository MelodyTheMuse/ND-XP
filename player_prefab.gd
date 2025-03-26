extends CharacterBody3D
@export var speed = 25
@export var jump_height = 10
@export var LOOKAROUND_SPEED = 0.1
@export var mouse_sensitivity = 0.1
@export_range(0.1, 3.0, 0.1, "or_greater") var camera_sens: float = 1
@export_range(10, 400, 1) var acceleration: float = 100 # m/s^2
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var forwards
var backwards
var left
var right
var jump
var look_dir
var move_dir
var walk_vel:Vector3

@export var camera:Camera3D

func _physics_process(delta):
	
	velocity.y -= gravity * delta
	velocity = _walk(delta)
	get_inputs()
	do_movements()
	move_and_slide()
	

func get_inputs():
	forwards = Input.is_action_pressed("Move_Forward")
	backwards = Input.is_action_pressed("Move_Backwards")
	left = Input.is_action_pressed("Move_Left")
	right = Input.is_action_pressed("Move_Right")
	jump = Input.is_action_pressed("Jump")

func _walk(delta: float) -> Vector3:
	move_dir = Input.get_vector(&"Move_Left", &"Move_Right", &"Move_Forward", &"Move_Backwards")
	var _forward: Vector3 = camera.global_transform.basis * Vector3(move_dir.x, 0, move_dir.y)
	var walk_dir: Vector3 = Vector3(_forward.x, 0, _forward.z).normalized()
	walk_vel = walk_vel.move_toward(walk_dir * speed * move_dir.length(), acceleration * delta)
	return walk_vel

	
func do_movements():
	velocity.x=0
	velocity.z=0
	if is_on_floor() && jump:
		velocity.y = jump_height
	if forwards:
		velocity.z -= speed
	if backwards:
		velocity.z += speed
	if left:
		velocity.x -= speed
	if right:
		velocity.x += speed
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

#func update_rotation():
	#var mousePos:Vector2 = get_viewport().get_mouse_position()
	#var from = camera.project_ray_origin(mousePos)
	#var raylength = 1000
	#var to = from + camera.project_ray_normal(mousePos) * raylength

func _input(event):
	var sens_mod = 1.0
	if event is InputEventMouseMotion:
		look_dir = event.relative * 0.01
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			camera.rotation.y -= look_dir.x * camera_sens * sens_mod
			camera.rotation.x = clamp(camera.rotation.x - look_dir.y * camera_sens * sens_mod, -1.5, 1.5)
				
				
