extends "res://Utility/SceneTransitions/SceneTransitionObject.gd"
class_name STOFromDoor

var newDoor = ""
var newDoorDir = ""


func _init(nd, ndd):
	newDoor = nd
	newDoorDir = ndd
