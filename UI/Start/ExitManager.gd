extends Panel


func _on_desktop_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Menus/MainMenu.tscn")
