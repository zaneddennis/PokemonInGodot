extends Panel


@onready var ui = get_parent()


var texts = []
var currentIx = -1


func Activate(dialogue):
	texts = dialogue.dialogue
	Next()
	
	if dialogue is NPCInteractable:
		$NPCName/MarginContainer/Label.text = dialogue.npcName
		$NPCName.show()
	else:
		$NPCName.hide()
	
	show()

func Close():
	currentIx = -1
	hide()


func Next():
	currentIx += 1
	
	if currentIx >= len(texts):
		ui.CloseDialogue()
	else:
		$MarginContainer/Label.text = texts[currentIx]
