extends CanvasLayer


var fromMenu = false

var newDoor = ""
var newDoorDir = ""


func FromDoor(door):
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	
	newDoor = door.destinationDoor
	newDoorDir = door.destinationDir
	
	get_tree().change_scene_to_file(door.GetDestinationPath())
	
	$AnimationPlayer.play_backwards("fade")


func FromMenu():
	fromMenu = true
	
	get_tree().change_scene_to_file("res://World/Maps/%s.tscn" % GameStatus.currentMap)


func Reset():
	fromMenu = false
	newDoor = ""
	newDoorDir = ""
