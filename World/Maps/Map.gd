extends Node2D


@export var mapName = ""


func _ready():
	print("Ready: ", scene_file_path)
	Activate()


func Activate():
	if SceneTransition.fromMenu:
		$Characters/Player.position = GameStatus.playerPosition
	elif SceneTransition.newDoor:
		$Characters/Player.position = get_node("Interactables/" + SceneTransition.newDoor).position + Constants.DIRECTIONS[SceneTransition.newDoorDir] * Constants.GRID_SIZE
	
	$Characters/Player.get_node("Sprite2D").region_rect.position.y = 128 * GameStatus.playerGender
	
	GameStatus.currentMap = mapName
	
	SceneTransition.Reset()
