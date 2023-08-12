extends Control



func _on_inventory_pressed():
	$Inventory.Activate()


func _on_save_pressed():
	$Save.show()


func _on_exit_pressed():
	$Exit.show()
