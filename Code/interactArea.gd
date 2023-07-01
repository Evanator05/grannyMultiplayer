extends Area3D

signal interacted(interactor, item)

func interact(interactor, item):
	emit_signal("interacted", interactor, item)
