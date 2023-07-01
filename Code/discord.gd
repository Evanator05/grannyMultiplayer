extends Node

var appId:int = 1113730148412432474

#func _ready():
#	discord_sdk.activity_join.connect(_on_activity_join)
#	discord_sdk.app_id = 1113730148412432474
#	# this is boolean if everything worked
#	var working = discord_sdk.get_is_discord_working()
#	if not working: return
#
#	setStatus("In the main menu", "Hosting a game", "hosting")
#
#func setStatus(details:String, state:String, largeImageText:String):
#	var working = discord_sdk.get_is_discord_working()
#	if not working: return
#
#	discord_sdk.details = details
#	discord_sdk.state = state
#	discord_sdk.large_image = "granny"
#	discord_sdk.large_image_text = largeImageText
#	discord_sdk.small_image = ""
#	discord_sdk.small_image_text = ""
#	discord_sdk.start_timestamp = int(Time.get_unix_time_from_system())
#	#discord_sdk.end_timestamp = int(Time.get_unix_time_from_system()) + 3600
#	discord_sdk.refresh()
#
#func createParty(matchSecret:String):
#	discord_sdk.party_id = "partyId"
#	discord_sdk.match_secret = matchSecret
#	discord_sdk.join_secret = matchSecret + ":join"
#	discord_sdk.spectate_secret = matchSecret + ":spectate"
#	discord_sdk.current_party_size = 1
#	discord_sdk.max_party_size = 5
#	discord_sdk.is_public_party = true
#	discord_sdk.instanced = true
#	discord_sdk.refresh()
#
#func _on_activity_join(secret:String):
#	var split = secret.split(":")
#	var code = split[0]
#	var _type = split[1]
#	ServerManager.findWithCode(code)
