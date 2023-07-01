extends Node3D

@export var keyName:String

func _on_interact_area_interacted(_interactor, item):
	if item == keyName:
		rpc("removeLock")

@rpc("any_peer", "reliable", "call_local")
func removeLock():
	queue_free()
 
