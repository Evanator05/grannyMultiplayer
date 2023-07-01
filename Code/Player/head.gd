extends Node3D

var onFloor:bool = false
var time:float = 0.0
var tiltDir:float = 0.0
var strength:float = 0.0

@export var speed:float = 10
@export var bobAmount:Vector2 = Vector2(0.02, 0.08)
@export var angularBob:float = 3 #degrees
@export var tiltAngle:float = 3 #degrees

@onready var camera:Camera3D = $Camera

func _process(delta):
	var active:float = int(onFloor)*strength
	time += delta*speed*strength
	
	while time > (2*PI)*2:
		time -= (2*PI)*2

	var verticalBounce:float = sin(time)*bobAmount.y #how much the camera moves up and down while walking
	var horizontalBounce:float = cos(time/2)*bobAmount.x #how much the camera moves left and right while walking
	var angularBounce:float = sin(time/2)*angularBob #how much the camera tilts left and right while walking
	
	var moveTilt:float = tiltAngle*(-tiltDir) #how much the camera tilts when moving left or right

	camera.position = camera.position.slerp(Vector3(horizontalBounce*active, verticalBounce*active, 0), easeAmount(delta))
	camera.rotation_degrees = camera.rotation_degrees.slerp(Vector3(0, 0, (angularBounce+moveTilt)*active), easeAmount(delta))

func easeAmount(delta) -> float:
	return 1 - pow(0.3, delta)
