extends ColorRect

@onready var serverName := $MarginContainer/VBoxContainer/Name
@onready var port := $MarginContainer/VBoxContainer/Port
@onready var private := $MarginContainer/VBoxContainer/Private

func _on_create_server_pressed():
	Network.upnp.discover()
	Network.upnp.add_port_mapping(port.value)
	var ip = Network.upnp.query_external_address()
	ServerManager.createServer(serverName.text, private.button_pressed, ip, port.value)
	Network.hostServer(port.value)
	get_tree().change_scene_to_file("res://Scenes/HostScreen.tscn")
