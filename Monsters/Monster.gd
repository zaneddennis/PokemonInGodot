extends Resource
class_name Monster


@export var name = ""
@export var index = 0
@export var type: Constants.TYPES

# base stats
@export_range(10, 50) var hp
@export_range(10, 50) var attack
@export_range(10, 50) var defense
@export_range(10, 50) var specialAttack
@export_range(10, 50) var specialDefense
@export_range(10, 50) var speed


func GetTextureCoords():
	return Rect2(0, 64*(index-1), 64, 64)


func _to_string():
	return "<%s>" % name
