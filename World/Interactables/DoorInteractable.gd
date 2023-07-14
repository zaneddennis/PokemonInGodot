extends Interactable

@export var destination: String = ""
@export var destinationDoor: String = ""
@export var destinationDir: String = "down"


func GetDestinationPath():
	return "res://World/Maps/" + destination + ".tscn"
