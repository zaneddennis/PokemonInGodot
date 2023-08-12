extends Control


@export var player: CharacterBody2D


func ActivateInteract(t):
	$InteractPrompt.text = t
	$InteractPrompt.show()

func CloseInteract():
	$InteractPrompt.hide()


func ActivateDialogue(dialogue):
	if dialogue is NPCInteractable:
		$Dialogue.Activate(dialogue.dialogue, dialogue.npcName)
	elif dialogue is DialogueInteractable:
		$Dialogue.Activate(dialogue.dialogue)
	elif dialogue is ChestInteractable:
		var texts = ["Found a %s!" % [dialogue.item.capitalize()]]
		$Dialogue.Activate(texts)

func AdvanceDialogue():
	$Dialogue.Next()

func CloseDialogue():
	$Dialogue.Close()
	player.inputMode = player.INPUT_MODE.NORMAL


func ActivateStart():
	$Start.show()

func CloseStart():
	$Start/Inventory.hide()
	$Start/Save.hide()
	$Start/Exit.hide()
	
	$Start.hide()
