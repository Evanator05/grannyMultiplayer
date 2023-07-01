extends Node3D

func isLocked() -> bool:
	return get_children().size() > 0
