extends CharacterBody2D


const WALK_SPEED = 96

var prevVelocity = Vector2.ZERO
var facing = ""
var walking = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ProcessMovement()


func ProcessMovement():
	if velocity != Vector2.ZERO:
		PlayWalkAnim(walking)
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
