extends Node


const FILEPATH = "user://gamestatus.save"


var playerName = "PLAYERNAME"
var playerGender = Constants.GENDER.BOY

@export var playerInventory : Inventory
@export var playerParty : Party

var currentMap = ""
var playerPosition = Vector2(0, 0)

var mapStatus = {}


func _ready():
	
	if not playerInventory:  # so that setting in Inspector works for testing individual scenes
		playerInventory = Inventory.new()
	
	if not playerParty:
		playerParty = Party.new()
	
	for mapName in Constants.MAPS:
		mapStatus[mapName] = {}


func NewGame(pn, pg):
	playerName = pn
	playerGender = pg
	
	playerInventory = Inventory.new()
	
	playerParty = Party.new()
	playerParty.AddMonster(
		MonsterInstance.New("Chipfunk")
	)
	playerParty.AddMonster(
		MonsterInstance.New("Squish")
	)
	playerParty.AddMonster(
		MonsterInstance.New("Bonfrog")
	)
	
	for mapName in Constants.MAPS:
		mapStatus[mapName] = {}


func SaveGame():
	print("Saving game state...")
	var saveData = {
		"playerName" : playerName,
		"playerGender" : playerGender,
		
		"playerInventory" : playerInventory.ToStr(),
		"playerParty" : playerParty.ToStr(),
		"mapStatus" : mapStatus,
		
		
		"currentMap" : currentMap,
		"playerPosition_x" : playerPosition.x,
		"playerPosition_y" : playerPosition.y,
	}
	
	var jsonStr = JSON.stringify(saveData)
	
	var file = FileAccess.open(FILEPATH, FileAccess.WRITE)
	file.store_line(jsonStr)
	print("Game state saved!")


func LoadGame():
	print("Loading Game Status...")
	
	var file = FileAccess.open(FILEPATH, FileAccess.READ)
	var contents = file.get_as_text()
	
	var data = JSON.parse_string(contents)
	
	# primitive fields
	for k in ["playerName", "playerGender", "currentMap"]:
		set(k, data[k])
	
	playerPosition = Vector2(data["playerPosition_x"], data["playerPosition_y"])
	playerInventory.FromStr(data["playerInventory"])
	playerParty.FromStr(data["playerParty"])
	mapStatus = data["mapStatus"]
	
	print("\tGame data loaded!")
