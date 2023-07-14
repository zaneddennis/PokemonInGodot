extends CanvasLayer


var newDoor = ""
var newDoorDir = ""


func Door(door):
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	
	newDoor = door.destinationDoor
	newDoorDir = door.destinationDir
	
	get_tree().change_scene_to_file(door.GetDestinationPath())
	
	$AnimationPlayer.play_backwards("fade")
