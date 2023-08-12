extends Resource
class_name Item


enum ITEM_TYPE {ITEM, MEDICINE, BALL, KEY}


@export var description: String
var itemType: ITEM_TYPE


func _to_string():
	return "<ItemData:%s:%s>" % [ITEM_TYPE.keys()[itemType], resource_path.get_file().get_basename()]
