extends "res://Characters/Character.gd"


const INTERACTION_RANGE = 8

enum INPUT_MODE {NORMAL, DIALOGUE, START}

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


func _input(event):
	match inputMode:
	
		INPUT_MODE.NORMAL:
			InputNormal()
		
		INPUT_MODE.DIALOGUE:
			InputDialogue()
		
		_:
			pass


func ProcessInteraction():
	$RayCast2D.target_position = Constants.DIRECTIONS[facing] * INTERACTION_RANGE
	
	if $RayCast2D.is_colliding():
		var target = $RayCast2D.get_collider()
		ui.ActivateInteract("Press [SPACE] to " + target.verb)
		potentialInteract = target
	else:
		ui.CloseInteract()
		potentialInteract = null


func InputNormal():
	if Input.is_action_pressed("ui_up"):
		Walk("up")
	elif Input.is_action_pressed("ui_down"):
		Walk("down")
	elif Input.is_action_pressed("ui_left"):
		Walk("left")
	elif Input.is_action_pressed("ui_right"):
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


func Start():
	StopWalk()
	ui.ActivateStart()
	inputMode = INPUT_MODE.START

func AdvanceDialogue():
	ui.AdvanceDialogue()

func EnterDoor(door):
	SceneTransition.Door(door)
