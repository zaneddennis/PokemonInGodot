extends Panel


var PartyMonsterWidget = load("res://UI/Start/PartyMonsterWidget.tscn")


func Activate(refresh=false):
	visible = !visible or refresh
	
	if visible:
		for pmw in $VBoxContainer.get_children():
			pmw.queue_free()
		
		var monsters = GameStatus.playerParty.GetMonsters()
		
		for mi in monsters:
			var pmw = PartyMonsterWidget.instantiate()
			$VBoxContainer.add_child(pmw)
			
			pmw.monsterInstance = mi
			pmw.get_node("Species").text = mi.species.name
			pmw.get_node("TextureRect").texture.region = mi.species.GetTextureCoords()
			
			pmw.mouse_entered.connect(self._on_pmw_hovered.bind(pmw))
			pmw.mouse_exited.connect(self._on_pmw_unhovered.bind(pmw))
		
		if len(monsters) > 0:
			ActivateStats(monsters[-1])


# todo: pad to always be 2 digits
func ActivateStats(mi):
	$Stats/XP.text = "XP: %s/%s" % ["0000", "0000"]
	$Stats/Attack.text = "ATTACK:    %s" % mi.GetStat("attack")
	$Stats/Defense.text = "DEFENSE:   %s" % mi.GetStat("defense")
	$Stats/SpecialAttack.text = "SP ATT:    %s" % mi.GetStat("specialAttack")
	$Stats/SpecialDefense.text = "SP DEF:    %s" % mi.GetStat("specialDefense")
	$Stats/Speed.text = "SPEED:     %s" % mi.GetStat("speed")


func _on_pmw_hovered(pmw):
	ActivateStats(pmw.monsterInstance)
	pmw.get_node("Highlight").show()

func _on_pmw_unhovered(pmw):
	pmw.get_node("Highlight").hide()
	

func _can_drop_data(at_position, data):
	#print("testing if can drop")
	return $VBoxContainer.get_rect().has_point(at_position)

func _drop_data(at_position, data):
	print("dropping dragged ", data, " at ", at_position.y)
	
	# get new index
	var currPositions = []
	for pmw in $VBoxContainer.get_children():
		currPositions.append(pmw.position.y)
	
	var i = 0
	for p in currPositions:
		if at_position.y < p:
			break
		else:
			i += 1
	
	# reshuffle Party order
	var mi = GameStatus.playerParty.data[data]
	GameStatus.playerParty.data.insert(i, mi)
	
	if i < data:
		GameStatus.playerParty.data.remove_at(data+1)
	else:
		GameStatus.playerParty.data.remove_at(data)
	
	# refresh widgets
	Activate(true)
