extends Node2D


func _ready():
	print("Ready: ", scene_file_path)
	Activate()


# check SceneTransition for scene setup details?
func Activate():
	if SceneTransition.newDoor:
		$Characters/Player.position = get_node("Interactables/" + SceneTransition.newDoor).position + Constants.DIRECTIONS[SceneTransition.newDoorDir] * Constants.GRID_SIZE
