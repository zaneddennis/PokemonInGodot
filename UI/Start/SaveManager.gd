extends Panel


func _on_confirm_pressed():
	get_node("/root/Map").Close()
	GameStatus.SaveGame()
	
	$Confirm.disabled = true
	$Confirm.text = "Game saved!"
