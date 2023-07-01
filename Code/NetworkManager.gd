extends Node

var upnp:UPNP = UPNP.new()
var net:ENetMultiplayerPeer = ENetMultiplayerPeer.new()

var players := {}

signal updatePlayerList(players)

func _ready():
	net.peer_connected.connect(playerConnected)
	net.peer_disconnected.connect(playerDisconnected)
	multiplayer.connection_failed.connect(connectionFailed)
	multiplayer.connected_to_server.connect(connectedToServer)

@rpc("reliable")
func syncPlayerList(value):
	players = value
	net.emit_signal("peer_connected")

func joinServer(ip:String, port:int):
	net.create_client(ip, port)
	multiplayer.multiplayer_peer = net

func connectedToServer():
	get_tree().change_scene_to_file("res://Scenes/JoinScreen.tscn")
	if Settings.playerName != "":
		rpc_id(1, "setUsername", Settings.playerName)
	
func connectionFailed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func hostServer(port:int):
	net.create_server(port)
	multiplayer.multiplayer_peer = net
	playerConnected(1)
	if Settings.playerName != "":
		players[1]["playerName"] = Settings.playerName
	
func playerConnected(id):
	players[id] = {"playerName": "guest"}
	
func playerDisconnected(id):
	players.erase(id)

@rpc("any_peer", "reliable", "call_local")
func setUsername(playerName:String):
	players[multiplayer.get_remote_sender_id()]["playerName"] = playerName
	emit_signal("updatePlayerList", players)

@rpc("reliable", "call_local")
func startGame(mapPath:String):
	net.host.refuse_new_connections(true)
	get_tree().change_scene_to_file(mapPath)
