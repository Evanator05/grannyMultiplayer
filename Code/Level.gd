extends Node3D

@onready var player := load("res://Objects/Player.tscn")
@onready var spawnPoints = $PlayerSpawns.get_children()


func _ready():
	Network.net.peer_disconnected.connect(removePlayer)
	for id in Network.players:
		print(id)
		addPlayer(id)

func addPlayer(id):
	var playerInst = player.instantiate()
	playerInst.set_multiplayer_authority(id)
	playerInst.name = str(id)
	playerInst.setNametag(Network.players[id]["playerName"])
	add_child(playerInst)
	playerInst.global_transform = spawnPoints[0].global_transform

func removePlayer(id):
	get_node(str(id)).queue_free()
