extends Node

var http:HTTPRequest = HTTPRequest.new()
var url = "http://50.99.113.163:25565/"
var header = ["Content-Type: application/json"]

var server := {}

func _ready():
	add_child(http)
	if "--localHost" in OS.get_cmdline_args():
		url = "http://127.0.0.1:25565/"

func makeHttpRequest(route:String, dict:Dictionary, method:HTTPClient.Method):
	var json = JSON.stringify(dict)
	http.cancel_request()
	http.request(url+route, header, method, json)
	var response = await http.request_completed
	if response[1] != 200: return "{}"
	return response[3].get_string_from_utf8()

func askServerForLobby(code:String):
	var response = await makeHttpRequest("getWithCode", {"code": code}, HTTPClient.METHOD_POST)
	return JSON.parse_string(response)
	
func getServers():
	var response = await makeHttpRequest("sendServers", {}, HTTPClient.METHOD_GET)
	return JSON.parse_string(response)

func createServer(serverName:String, private:bool, ip:String, port:int):
	var dict = {
		"serverName": serverName,
		"private": private,
		"ip": ip,
		"port": port
	}
	var response = await makeHttpRequest("addServer", dict, HTTPClient.METHOD_POST)
	if not server.has("code"):
		print(server)
		return
	server = JSON.parse_string(response)
	#Discord.createParty(server["code"])

func removeServer():
	#makeHttpRequest("removeServer", server, HTTPClient.METHOD_POST)
	pass
