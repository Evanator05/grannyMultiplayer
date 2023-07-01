class_name MenuTabManager extends Control

@export var startingTab:int = 0

@onready var tabs := get_children()

func _ready():
	changeTab(startingTab)

func changeTab(tabId):
	for tab in tabs:
		tab.visible = false
	tabs[tabId].selectTab()
