extends CharacterBody2D


signal footstep


const WALK_SPEED = 96

var prevVelocity = Vector2.ZERO
@export var facing = ""
var walking = ""

const FOOTSTEP_INTERVAL = 0.5
var footstepTimer = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	StopWalkAnim()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ProcessMovement(delta)


func ProcessMovement(delta):
	if velocity != Vector2.ZERO:
		PlayWalkAnim(walking)
		
		footstepTimer += delta
		if footstepTimer >= FOOTSTEP_INTERVAL:
			footstep.emit()
			footstepTimer = 0.0
		
	elif prevVelocity != Vector2.ZERO:
		StopWalkAnim()
	
	prevVelocity = velocity
	move_and_slide()


func Walk(dir):
	facing = dir
	walking = dir
	velocity = Constants.DIRECTIONS[dir] * WALK_SPEED

func StopWalk():
	walking = ""
	velocity = Vector2.ZERO

func PlayWalkAnim(dir):
	$Sprite2D/AnimationPlayer.play("walk_" + dir)

func StopWalkAnim():
	$Sprite2D/AnimationPlayer.play("idle_" + facing)
