extends MeshInstance3D

@onready var dummyCam:Marker3D = $origin/dummyCamera
@onready var origin:Node3D = $origin
@onready var camera:Camera3D = $SubViewport/Camera3D

@export var maxDistance:float = 50

func _ready():
	setupCam()

func setupCam():
	var mat = load("res://Materials/Mirror.material").duplicate(true)
	mat.set_shader_parameter("mirrorTexture", $SubViewport.get_texture())
	mesh.surface_set_material(0, mat)

func camPos():
	dummyCam.global_transform = get_window().get_viewport().get_camera_3d().global_transform
	origin.scale *= Vector3(1, 1, -1)
	return dummyCam.global_transform

func getDepth():
	var pos = dummyCam.position
	var dist = sqrt(pos.x*pos.x+pos.y*pos.y+pos.z*pos.z)
	camera.near = clamp(dist, 0.001, maxDistance)
	return clamp(dist, 0.001, maxDistance)

func cameraSettings():
	var viewport = get_window().get_viewport()
	camera.fov = viewport.get_camera_3d().fov
	var size:Vector2 = viewport.size
	var dist:float = getDepth()
	var percent:float = 1 - dist/maxDistance
	var _ajusted:Vector2 = viewport.size*percent
	$SubViewport.size = size

func _process(_delta):
	camera.global_transform = camPos()
	cameraSettings()
