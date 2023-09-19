extends Panel

var monsterInstance: MonsterInstance


func _get_drag_data(at_position):
	var preview = Panel.new()
	preview.custom_minimum_size = Vector2(96, 24)
	var label = Label.new()
	label.set_anchors_preset(Control.PRESET_FULL_RECT)
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	label.text = monsterInstance.species.name
	preview.add_child(label)
	
	set_drag_preview(preview)
	
	return get_index()
