extends SpotLight3D

@export var targetNode:Node3D

@rpc("any_peer", "call_local", "unreliable")
func toggleFlashlight():
	light_energy = int(not bool(light_energy))

func _process(delta):
	global_transform.basis = global_transform.basis.slerp(targetNode.global_transform.basis.orthonormalized(), 1-pow(0.002,delta))
	global_transform.origin = global_transform.origin.slerp(targetNode.global_transform.origin, 1-pow(0.00002,delta))
