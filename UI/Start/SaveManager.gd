extends Panel


func _on_confirm_pressed():
	GameStatus.SaveGame()
	
	$Confirm.disabled = true
	$Confirm.text = "Game saved!"
