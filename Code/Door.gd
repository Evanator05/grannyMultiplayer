extends StaticBody3D

func _on_interact_area_interacted(_interactor, _item):
	if get_node_or_null("Locks"):
		if get_node("Locks").isLocked(): return
	
	var impulse = 400
	if abs($door.rotation_degrees.y)>60:
		impulse *= -1

	rpc("applyTorque", Vector3(0,impulse,0))

@rpc("any_peer", "call_local", "reliable")
func applyTorque(torque:Vector3):
	$door.apply_torque(torque)

func _on_area_3d_3_body_entered(body):
	if body.name == "door":
		$door.linear_velocity = Vector3(0, 0, 0)
		$door.angular_velocity = Vector3(0, 0, 0)
		$door.position = Vector3(0, 3, 0)
		$door.rotation_degrees.y = 0


func _on_area_3d_2_body_entered(body):
	if body.name == "door":
		$door.linear_velocity = Vector3(0, 0, 0)
		$door.angular_velocity = Vector3(0, 0, 0)
		$door.rotation_degrees.y = 90
