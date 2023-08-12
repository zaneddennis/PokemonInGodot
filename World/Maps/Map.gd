extends Node2D


@export var mapName = ""

# persisted information
var persistent_remove_chests = []


func _ready():
	print("Ready: ", scene_file_path)
	Activate()


func Activate():
	GetMapStatus()
	
	if SceneTransition.fromMenu:
		if not SceneTransition.newGame:
			$Characters/Player.position = GameStatus.playerPosition
	elif SceneTransition.newDoor:
		$Characters/Player.position = get_node("Interactables/" + SceneTransition.newDoor).position + Constants.DIRECTIONS[SceneTransition.newDoorDir] * Constants.GRID_SIZE
	
	$Characters/Player.get_node("Sprite2D").region_rect.position.y = 128 * GameStatus.playerGender
	
	GameStatus.currentMap = mapName
	
	# remove used chests
	for chestName in persistent_remove_chests:
		var chest = $Interactables.get_node(chestName)
		RemoveInteractable(chest)
	
	SceneTransition.Reset()


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
