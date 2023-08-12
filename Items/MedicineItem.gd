extends "res://Items/Item.gd"
class_name MedicineItem


enum MEDICINE_STAT {HP, AP}

@export var stat: MEDICINE_STAT
@export var amount = 0


func _init():
	itemType = ITEM_TYPE.MEDICINE
