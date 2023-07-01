extends RayCast3D

@export var player:Player

func interact(item:String) -> void:
	if Input.is_action_just_pressed("interact"):
		force_raycast_update()
		if is_colliding():
			var object:Object = get_collider()
			if object.is_in_group("interact"):
				object.interact(player, item)
 
