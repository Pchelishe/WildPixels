extends Marker3D

var target: Node3D
var camera: Camera3D

@export var Distance: Vector3 = Vector3(0, 0, 0)
@export var Target: NodePath


func _ready():
	target = get_node(Target) as Node3D
	camera = get_node("Camera") as Camera3D
	camera.position = Distance


func _process(delta):
	transform.origin = target.transform.origin
	target.cameraY = rotation.y

func _input(event: InputEvent) -> void:
	if event is InputEventMouse:
		mouseHandle(event as InputEventMouse)


func mouseHandle(event: InputEventMouse) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * 0.01
		rotation.x = clamp(rotation.x + event.relative.y * 0.01, -0.85, 0.15)
