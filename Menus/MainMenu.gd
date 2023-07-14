extends CanvasLayer


func _on_newgame_pressed():
	$HBoxContainer/Content/NewGame.show()


func _on_exit_pressed():
	get_tree().quit()


func _on_newgame_start_pressed():
	get_tree().change_scene_to_file("res://World/Maps/Flowershore.tscn")
