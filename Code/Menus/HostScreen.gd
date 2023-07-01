extends Control

func _on_button_pressed():
	ServerManager.removeServer()
	Network.rpc("syncPlayerList", Network.players)
	Network.rpc("startGame", "res://Scenes/Level.tscn")

func _on_code_pressed():
	if ServerManager.server == {}: return
	DisplayServer.clipboard_set(ServerManager.server["code"])
