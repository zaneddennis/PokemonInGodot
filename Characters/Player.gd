extends "res://Characters/Character.gd"
class_name Player


const INTERACTION_RANGE = 8

enum INPUT_MODE {NORMAL, DIALOGUE, START}

@export var map: Node2D
@export var ui: Control


var inputMode = INPUT_MODE.NORMAL

var potentialInteract = null


# Called when the node enters the scene tree for the first time.
func _ready():
	super()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	
	ProcessInteraction()
	
	UpdateGameStatus()
	
	# check for encounter?


func _input(event):
	match inputMode:
	
		INPUT_MODE.NORMAL:
			InputNormal()
		
		INPUT_MODE.DIALOGUE:
			InputDialogue()
		
		INPUT_MODE.START:
			InputStart()
		
		_:
			pass


func ProcessInteraction():
	$RayCast2D.target_position = Constants.DIRECTIONS[facing] * INTERACTION_RANGE
	
	if $RayCast2D.is_colliding():
		var target = $RayCast2D.get_collider()
		if target:
			ui.ActivateInteract("Press [SPACE] to " + target.verb)
			potentialInteract = target
	else:
		ui.CloseInteract()
		potentialInteract = null


func UpdateGameStatus():
	GameStatus.playerPosition = position


func InputNormal():
	if Input.is_action_pressed("walk_up"):
		Walk("up")
	elif Input.is_action_pressed("walk_down"):
		Walk("down")
	elif Input.is_action_pressed("walk_left"):
		Walk("left")
	elif Input.is_action_pressed("walk_right"):
		Walk("right")
	else:
		StopWalk()
	
	if Input.is_action_just_pressed("interact"):
		if potentialInteract:
			Interact(potentialInteract)
	
	if Input.is_action_just_pressed("start"):
		Start()


func InputDialogue():
	if Input.is_action_just_pressed("interact"):
		AdvanceDialogue()


func InputStart():
	if Input.is_action_just_pressed("start"):
		CloseStart()


func Interact(target):
	print("Interacting with " + target.name)
	StopWalk()
	if target.interactableType == Interactable.INTERACTABLE_TYPE.DIALOGUE:
		ui.ActivateDialogue(target)
		inputMode = INPUT_MODE.DIALOGUE
	elif target.interactableType == Interactable.INTERACTABLE_TYPE.DOOR:
		ui.CloseInteract()
		potentialInteract = null
		EnterDoor(target)
	elif target.interactableType == Interactable.INTERACTABLE_TYPE.CHEST:
		GameStatus.playerInventory.AddItem(target.item, 1)
		ui.ActivateDialogue(target)
		inputMode = INPUT_MODE.DIALOGUE
		map.RemoveInteractable(target)


func Start():
	StopWalk()
	ui.ActivateStart()
	inputMode = INPUT_MODE.START

func CloseStart():
	ui.CloseStart()
	inputMode = INPUT_MODE.NORMAL

func AdvanceDialogue():
	ui.AdvanceDialogue()

func EnterDoor(door):
	SceneTransition.FromDoor(door)
