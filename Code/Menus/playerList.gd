extends ItemList

func _ready():
	Network.updatePlayerList.connect(updatePlayerList)
	updatePlayerList(Network.players)
	
func updatePlayerList(players):
	clearItemList()
	for peer in Network.players:
		add_item(Network.players[peer]["playerName"])

func clearItemList():
	for i in item_count:
		remove_item(0)
