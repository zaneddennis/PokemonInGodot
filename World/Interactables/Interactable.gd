extends Area2D
class_name Interactable


enum INTERACTABLE_TYPE {DEFAULT, DIALOGUE, CHEST, DOOR, HEAL}

@export var interactableType = INTERACTABLE_TYPE.DEFAULT
@export var verb = ""
