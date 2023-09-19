extends CanvasLayer

var object: SceneTransitionObject


func FromDoor(door):
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	
	get_node("/root/Map").Close()
	
	object = STOFromDoor.new(
		door.destinationDoor,
		door.destinationDir
	)
	
	get_tree().change_scene_to_file(door.GetDestinationPath())
	
	$AnimationPlayer.play_backwards("fade")

func FromContinue():
	object = STOFromContinue.new()
	
	# GameStatus has already loaded the existing save at this point
	get_tree().change_scene_to_file("res://World/Maps/%s.tscn" % GameStatus.currentMap)

func FromNewGame():
	object = STONewGame.new()
	get_tree().change_scene_to_file("res://World/Maps/Flowershore.tscn")


func Reset():
	object = null
