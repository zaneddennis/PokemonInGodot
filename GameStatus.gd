extends Node


const FILEPATH = "user://gamestatus.save"


var playerName = "PLAYERNAME"
var playerGender = Constants.GENDER.BOY
var playerInventory = Inventory.new()

var currentMap = ""
var playerPosition = Vector2(0, 0)

var mapStatus = {}


func _ready():
	for mapName in Constants.MAPS:
		mapStatus[mapName] = {}


func SaveGame():
	print("Saving game state...")
	var saveData = {
		"playerName" = playerName,
		"playerGender" = playerGender,
		
		"playerInventory" = playerInventory.ToStr(),
		"mapStatus" = mapStatus,
		
		
		"currentMap" = currentMap,
		"playerPosition_x" = playerPosition.x,
		"playerPosition_y" = playerPosition.y,
	}
	
	var jsonStr = JSON.stringify(saveData)
	
	var file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	file.store_line(jsonStr)
	print("Game state saved!")


func LoadGame():
	print("Loading game state...")
	
	var file = FileAccess.open(FILEPATH, FileAccess.READ)
	var contents = file.get_as_text()
	
	var data = JSON.parse_string(contents)
	
	# primitive fields
	for k in ["playerName", "playerGender", "currentMap"]:
		set(k, data[k])
	
	playerPosition = Vector2(data["playerPosition_x"], data["playerPosition_y"])
	playerInventory.FromStr(data["playerInventory"])
	mapStatus = data["mapStatus"]
	
	print("Game data loaded!")
