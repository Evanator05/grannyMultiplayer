class_name MenuTab extends Control

@export var startingButton:Button

func selectTab():
	visible = true
	startingButton.grab_focus()
