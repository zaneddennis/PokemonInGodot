extends "res://Characters/Character.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)


func _input(event):
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
