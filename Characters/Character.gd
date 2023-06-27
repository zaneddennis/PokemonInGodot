extends CharacterBody2D


var facing = ""
var walking = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ProcessMovement()


func ProcessMovement():
	velocity = Vector2(64, 0)
	move_and_slide()


func Walk(dir):
	facing = dir
	walking = dir
	$Sprite2D/AnimationPlayer.play("walk_" + dir)

func StopWalk(dir):
	facing = dir
	walking = ""
	$Sprite2D/AnimationPlayer.play("idle_" + dir)
