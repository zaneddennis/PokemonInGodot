extends Node2D


const ENCOUNTER_PROB = 0.3  # per footstep


@export var player: Player

@export var mapName = ""
@export var encounterTable : Dictionary  # values should sum to 1!

var tileData : TileData  # data for where the player is currently standing

var persistent_remove_chests = []


func _ready():
	print("Ready: ", scene_file_path)
	Activate()


func _process(delta):
	var playerPos = $Characters/Player.position
	var playerCoords = $TileMap.local_to_map(playerPos)
	tileData = $TileMap.get_cell_tile_data(Constants.LAYERS["Objects"], playerCoords)


func Activate():
	print("Activating map ", mapName)
	
	if SceneTransition.object:
		if SceneTransition.object is STOFromDoor:
			ActivateFromDoor(SceneTransition.object)
		elif SceneTransition.object is STOFromContinue:
			ActivateFromContinue()
		elif SceneTransition.object is STONewGame:
			ActivateNewGame()
		else:
			assert(false)
	else:
		ActivateFromEditor()
	
	# set gender sprite
	$Characters/Player.get_node("Sprite2D").region_rect.position.y = 128 * GameStatus.playerGender
	
	GetMapStatus()
	for chestName in persistent_remove_chests:
		var chest = $Interactables.get_node(chestName)
		RemoveInteractable(chest)
	
	GameStatus.currentMap = mapName
	SceneTransition.Reset()

func ActivateFromDoor(sto):
	print("\tFrom Door")
	$Characters/Player.position = get_node("Interactables/" + sto.newDoor).position + \
		Constants.DIRECTIONS[sto.newDoorDir] * Constants.GRID_SIZE

func ActivateFromContinue():
	print("\tFrom Continue")
	$Characters/Player.position = GameStatus.playerPosition

func ActivateNewGame():
	print("\tFrom New Game")

func ActivateFromEditor():
	print("\tFrom Editor")


func Close():
	PersistMapStatus()


# where target is both TileMap Object and an Interactable
func RemoveInteractable(target):
	var coords = $TileMap.local_to_map(target.position)
	$TileMap.erase_cell(Constants.LAYERS["Objects"], coords)
	target.queue_free()
	
	if not target.name in persistent_remove_chests:
		persistent_remove_chests.append(String(target.name))


func PersistMapStatus():
	GameStatus.mapStatus[mapName]["persistent_remove_chests"] = persistent_remove_chests


func GetMapStatus():
	var mapStatus = GameStatus.mapStatus[mapName]
	
	if "persistent_remove_chests" in mapStatus:
		persistent_remove_chests = mapStatus["persistent_remove_chests"]


func _on_player_footstep():
	print("Player footstep")
	if tileData:
		if tileData.get_custom_data("encounter"):
			var roll = randf()
			if roll < ENCOUNTER_PROB:
				print("Wild Monster!")
