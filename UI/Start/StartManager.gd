extends Control


func _on_index_pressed():
	$Index.Activate()


func _on_party_pressed():
	$Party.Activate()


func _on_inventory_pressed():
	$Inventory.Activate()


func _on_save_pressed():
	$Save.Activate()


func _on_exit_pressed():
	$Exit.show()
