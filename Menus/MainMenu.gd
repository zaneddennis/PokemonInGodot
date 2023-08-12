extends CanvasLayer


func _ready():
	if FileAccess.file_exists(GameStatus.FILEPATH):
		GameStatus.LoadGame()
		ActivateContinue()


func ActivateContinue():
	$HBoxContainer/Menu/ColorRect/MarginContainer/VBoxContainer/Continue/Button.text = \
	"Continue\n\n%s:\n%s" % [GameStatus.playerName, GameStatus.currentMap]
	
	$HBoxContainer/Menu/ColorRect/MarginContainer/VBoxContainer/Continue/Button.disabled = false



func NewGame():
	GameStatus.playerName = $HBoxContainer/Content/NewGame/VBoxContainer/PlayerName.text
	GameStatus.playerGender = $HBoxContainer/Content/NewGame/VBoxContainer/OptionButton.get_selected_id()
	GameStatus.currentMap = "Flowershore"
	SceneTransition.FromMenu(true)


func ContinueGame():
	SceneTransition.FromMenu(false)


func _on_newgame_pressed():
	$HBoxContainer/Content/NewGame.show()


func _on_continue_pressed():
	ContinueGame()


func _on_exit_pressed():
	get_tree().quit()


func _on_newgame_start_pressed():
	NewGame()
