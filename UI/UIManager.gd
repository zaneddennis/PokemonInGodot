extends Control


func ActivateInteract(t):
	$InteractPrompt.text = t
	$InteractPrompt.show()

func CloseInteract():
	$InteractPrompt.hide()


func ActivateDialogue(ts):
	$Dialogue.texts = ts
	$Dialogue.show()

func CloseDialogue():
	$Dialogue.hide()
