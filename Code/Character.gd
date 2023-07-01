extends Node3D

var walkBlendPos:Vector2 = Vector2(0, 0)

@export var player:Player

var timer = 1.6667

func setBlendSpace(pos:Vector2):
	walkBlendPos = pos

func getRotationDiff():
	return -(player.rotation_degrees.y - rotation_degrees.y - 180)

func setVisiblilityLayers(value):
	$Armature_012/Skeleton3D/Beta_Joints.layers = value
	$Armature_012/Skeleton3D/Beta_Surface.layers = value

func _process(delta):
	global_transform.origin = player.global_transform.origin
	global_transform.origin.y -= 2
	rotation_degrees.y -= getRotationDiff()

	var weight = 1-pow(0.002,delta)
	lerpParam("parameters/walking/blend_position", walkBlendPos, weight)

func lerpParam(param, value, weight):
	var paramToLerp = $AnimationTree.get(param)
	paramToLerp = lerp(paramToLerp, value, weight)
	$AnimationTree.set(param, paramToLerp)
