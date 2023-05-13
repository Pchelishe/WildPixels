extends CharacterBody3D

@export var speed: float = 12
@export var gravity: float = 800
var cameraY: float = 0

var direction: Vector3 = Vector3.ZERO
var motionArray: Array = [
	{
		Motion = "move_forward",
		Vector = Vector3.FORWARD
	},
	{
		Motion = "move_back",
		Vector = Vector3.BACK
	},
	{
		Motion = "move_left",
		Vector = Vector3.LEFT
	},
	{
		Motion = "move_right",
		Vector = Vector3.RIGHT
	}
]


func _ready() -> void:
	pass


func _physics_process(delta):
	velocity = gravity * delta * Vector3.DOWN
	
	if direction != Vector3.ZERO:
		velocity.x = direction.normalized().x * speed
		velocity.z = direction.normalized().z * speed
		velocity = velocity.rotated(Vector3.UP, cameraY)
		transform.basis = Basis(Quaternion(transform.basis)
			.slerp(Quaternion(Basis.looking_at(Vector3(velocity.x, 0, velocity.z), Vector3.UP)), 10 * delta))
		move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		keyHandle(event as InputEventKey)
	
	if event is InputEventMouse:
		mouseHandle(event as InputEventMouse)


func keyHandle(event: InputEventKey) -> void:
	
	for motion in motionArray:
		if event.is_action_pressed(motion.Motion):
			direction += motion.Vector
		
		if event.is_action_released(motion.Motion):
			direction -= motion.Vector


func mouseHandle(event: InputEventMouse) -> void:
	if event is InputEventMouseButton:
		pass
