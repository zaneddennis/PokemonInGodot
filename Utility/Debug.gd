extends Node


func _input(event):
	if Input.is_action_just_pressed("debug_quit"):
		get_tree().quit()
