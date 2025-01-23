extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENSITIVITY = 0.1;

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	var mouse_motion_event := event as InputEventMouseMotion
	if mouse_motion_event:
		$Camera.rotate_y(-deg_to_rad( MOUSE_SENSITIVITY * mouse_motion_event.relative.x))
		$Camera.rotate_object_local(Vector3(1, 0, 0), -deg_to_rad(MOUSE_SENSITIVITY * mouse_motion_event.relative.y))
		$Camera.rotation_degrees.x = clamp($Camera.rotation_degrees.x, -70, 70);

func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("game_quit")):
		get_tree().quit();

func _physics_process(delta: float) -> void:
	if not is_on_floor(): velocity += get_gravity() * delta
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction: Vector3 = ($Camera.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
