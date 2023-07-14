extends Control


@export var player: CharacterBody2D


func ActivateInteract(t):
	$InteractPrompt.text = t
	$InteractPrompt.show()

func CloseInteract():
	$InteractPrompt.hide()


func ActivateDialogue(dialogue):
	$Dialogue.Activate(dialogue)

func AdvanceDialogue():
	$Dialogue.Next()

func CloseDialogue():
	$Dialogue.Close()
	player.inputMode = player.INPUT_MODE.NORMAL


func ActivateStart():
	$Start.show()
