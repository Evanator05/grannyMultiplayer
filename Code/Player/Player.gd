class_name Player extends CharacterBody3D

signal playerDied()
@export var gravity: float = 45

@export var maxSpeed: float = 6
@export var normalAcceleration: float = 8
@export var airAcceleration: float = 1
@onready var horizontalAcceleration:float = normalAcceleration

#jumping
@export var jumpForce: float = 8
@export var jumpSpeedMultiplier: float = 0.35
var tryJump: float = 0

@export var mouseSensitivity: float = 0.1
@export var stickSensitivity: float = 360

var horizontalVelocity:Vector3 = Vector3()
var movement:Vector3 = Vector3()
var gravityVector:Vector3 = Vector3()

@onready var head:Node3D = $head
@onready var interactCast:RayCast3D = $head/interactCast
@onready var floorCast:RayCast3D = $floorCast
@onready var camera:Camera3D = $head/Camera
@onready var flashlight = $flashLight

var currentItem:String = ""

func _ready() -> void:
	add_to_group("Player")
	if not is_multiplayer_authority(): 
		$Character.setVisiblilityLayers(1)
		return
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera.current = true
	$NameTag.visible = false

func _input(event:InputEvent) -> void:
	if not is_multiplayer_authority(): return
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotation.y += deg_to_rad(-event.relative.x * mouseSensitivity)
			head.rotation.x += deg_to_rad(-event.relative.y * mouseSensitivity)
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-79), deg_to_rad(89))

func _process(delta:float) -> void:
	if not is_multiplayer_authority(): return
	aimHead(delta)
	alive(delta)

func alive(delta:float) -> void:
	var fullContact:bool = floorCast.is_colliding()
	
	if not is_on_floor():
		gravityVector += Vector3.DOWN * gravity * delta
		horizontalAcceleration = airAcceleration
	elif is_on_floor() and fullContact:
		gravityVector = -get_floor_normal() * gravity * delta
		horizontalAcceleration = normalAcceleration
	else:
		gravityVector = -get_floor_normal()
	
	#jumping
	tryJump -= delta
	if Input.is_action_just_pressed("jump"):
		tryJump = 0.2
	if tryJump > 0: #the player attempts to jump if tryJump is greater than 0
		jump()
	if Input.is_action_just_released("jump") and gravityVector.y > jumpForce/2:
		gravityVector.y = jumpForce/2
	
	var dir:Vector2 = Input.get_vector("moveLeft", "moveRight", "moveForward", "moveBackward")
	$Character.setBlendSpace(dir)
	var direction:Vector3 = getMoveDir(dir)
	var updatedMaxSpeed:float = maxSpeed*direction.length()
	
	horizontalVelocity = horizontalVelocity.lerp(direction*updatedMaxSpeed, horizontalAcceleration * delta)
	movement.z = horizontalVelocity.z + gravityVector.z
	movement.x = horizontalVelocity.x + gravityVector.x
	movement.y = gravityVector.y
	
	set_velocity(movement)
	move_and_slide()
	
	if Input.is_action_just_pressed("toggleFlashlight"):
		flashlight.rpc("toggleFlashlight")
	interactCast.interact(currentItem)
	
	head.onFloor = is_on_floor()
	head.tiltDir = dir.x
	head.strength = direction.length()
	if (round(movement.z) != 0 or round(movement.x) != 0) and is_on_floor():
		pass

func aimHead(delta:float) -> void:
	var aim:Vector2 = Input.get_vector("aimRight", "aimLeft", "aimDown", "aimUp")
	rotation_degrees.y += aim.x*stickSensitivity*delta
	head.rotation_degrees.x += aim.y*stickSensitivity*delta
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-79), deg_to_rad(89))

func getMoveDir(dir:Vector2) -> Vector3:
	var direction = Vector3()
	direction += transform.basis.z*dir.y
	direction += transform.basis.x*dir.x
	if direction.length() > 1:
		direction = direction.normalized()
	return direction

func jump() -> void:
	if is_on_floor(): #regular jump
		gravityVector.y = jumpForce
		gravityVector += get_platform_velocity()
		horizontalVelocity += horizontalVelocity*jumpSpeedMultiplier
		tryJump = 0

func die(_dealer) -> void:
	get_tree().reload_current_scene()

func setNametag(playerName:String):
	$NameTag.text = playerName
