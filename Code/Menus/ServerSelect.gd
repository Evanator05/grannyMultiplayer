extends MenuTab

@onready var itemList := $Server/ServerList

var servers:Dictionary

func _ready():
	refreshServerList()

func refreshServerList():
	addServersToList(await ServerManager.getServers())

func findWithCode(code:String):
	connectToServer(await ServerManager.askServerForLobby(code))

func connectToServer(dict:Dictionary):
	if dict.has("error"):
		$Server/code.placeholder_text = dict["error"]
		$Server/code.text = ""
		return
	
	$Server.visible = false
	$CreateServer.visible = false
	$Connecting.visible = true
	Network.joinServer(dict["ip"], dict["port"])

func addServersToList(s:Dictionary):
	servers = s
	#remove existing items from list
	for i in itemList.item_count:
		itemList.remove_item(0)
	
	for server in s.keys():
		itemList.add_item(s[server]["serverName"])

func openCreateServer():
	itemList.visible = false
	$CreateServer.visible = true

func _on_server_list_item_activated(index):
	var code = servers.keys()[index]
	findWithCode(code)

func _on_find_with_code_pressed():
	findWithCode($Server/code.text)

func _on_find_with_ip_pressed():
	var ipPort = $Server/ip.text.split(":")
	connectToServer({"ip": ipPort[0], "port": int(ipPort[1])})
