extends Control


enum BATTLE_STAGE {DEPLOY, POLL, EXECUTE, KO, CONCLUDE}


@export var playerParty: Party
@export var enemyParty: Party

var playerMonster: MonsterInstance
var enemyMonster: MonsterInstance

var actions = []
var nextAction = 0
var ko = false

@export var debugResetParties = true


var stage : BATTLE_STAGE = BATTLE_STAGE.DEPLOY


func _ready():
	for mb in $Panel/Fight/HBoxContainer.get_children():
		mb.pressed.connect(_on_move_pressed.bind(mb.get_index()))
	
	
	# if we are running this scene by itself (in actual game, _ready will not be used for deploy)
	if get_tree().current_scene.name == "Battle":
		assert(playerParty)
		assert(enemyParty)
		
		if debugResetParties:
			playerParty.RestoreAll()
			enemyParty.RestoreAll()
		
		# use Parties from Inspector
		ActivateDeploy()

func _process(delta):
	$Stage.text = "Stage: " + BATTLE_STAGE.keys()[stage]
	
	match stage:
		BATTLE_STAGE.DEPLOY:
			ProcessDeploy()
		
		BATTLE_STAGE.EXECUTE:
			ProcessExecute()
		
		BATTLE_STAGE.KO:
			ProcessKO()
		
		_:
			pass


func ActivateDeploy():
	stage = BATTLE_STAGE.DEPLOY
	
	playerMonster = playerParty.GetMonsters()[0]
	enemyMonster = enemyParty.GetMonsters()[0]
	
	DeployMonster(playerMonster, $PlayerMonster, true)
	DeployMonster(enemyMonster, $EnemyMonster, false)
	
	# todo: trainer messages
	$Panel/Report.text = "Enemy %s wants to fight!" % enemyMonster.species.name.to_upper()
	
	# deactivate Action buttons
	for b in $ChooseAction/GridContainer.get_children():
		b.disabled = true
		b.mouse_filter = Control.MOUSE_FILTER_IGNORE

func DeployMonster(mi, mUI, isPlayer):
	var msw = mUI.get_node("MonsterStatusWidget")
	
	msw.get_node("Species").text = mi.species.name
	msw.get_node("Level").text = "Lv %02d" % mi.GetLevel()
	
	msw.get_node("HP").text = "%d/%d" % [mi.hp, mi.GetStat("hp")]
	msw.get_node("HPBar").max_value = mi.GetStat("hp")
	msw.get_node("HPBar").value = mi.hp
	
	if isPlayer:
		msw.get_node("XPBar").max_value = mi.GetXPRequired()
		msw.get_node("XPBar").value = mi.GetXPModulo()
	
	mUI.texture.region = mi.species.GetTextureCoords()

func ProcessDeploy():
	if Input.is_action_just_pressed("interact"):
		ActivatePoll()


func ActivatePoll():
	stage = BATTLE_STAGE.POLL
	
	for b in $ChooseAction/GridContainer.get_children():
		b.disabled = false
		b.mouse_filter = Control.MOUSE_FILTER_STOP
	
	$Panel/Report.text = "Choose an action!"

func ClearSubPolls():
	$Panel/Fight.hide()
	$Panel/Party.hide()
	$Panel/Item.hide()

func ActivateFight():
	ClearSubPolls()
	$Panel/Fight.show()
	$Panel.SetText("Which move to use?")
	
	for i in range(4):
		var mButton = get_node("Panel/Fight/HBoxContainer/Move" + str(i))
		
		if i < len(playerMonster.moves):
			var move = playerMonster.moves[i]
			mButton.disabled = false
			mButton.text = move.name
		else:
			mButton.disabled = true
			mButton.text = ""

func ConcludePoll(playerAction):
	# get enemy Action
	var enemyAction = MoveAction.new(
		enemyMonster.moves[0],  # todo: select random move
		enemyMonster.GetStat("speed"),
		enemyMonster,
		playerMonster
	)
	
	ClearSubPolls()
	
	# todo: make this a function
	for b in $ChooseAction/GridContainer.get_children():
		b.disabled = true
		b.mouse_filter = Control.MOUSE_FILTER_STOP
	
	ActivateExecute(playerAction, enemyAction)


func ActivateExecute(playerAction, enemyAction):
	stage = BATTLE_STAGE.EXECUTE
	
	if playerAction.priority >= enemyAction.priority:
		actions = [playerAction, enemyAction]
	else:
		actions = [enemyAction, playerAction]
	
	print(actions)
	nextAction = 0
	
	AnnounceAction(actions[0])

func ProcessExecute():
	if Input.is_action_just_pressed("interact"):
		if ko:
			ActivateKO(ko)
		elif nextAction * -1 >= len(actions):
			ActivatePoll()
		else:
			if nextAction >= 0:
				ExecuteAction(actions[nextAction])
				ko = CheckForKO()
			else:
				nextAction *= -1
				AnnounceAction(actions[nextAction])

func AnnounceAction(a):
	$Panel/Report.text = a.message

func ExecuteAction(a):
	a.Execute()
	nextAction += 1
	
	var mi = null
	var msw = null
	if a.target == playerMonster:
		mi = playerMonster
		msw = $PlayerMonster/MonsterStatusWidget
	elif a.target == enemyMonster:
		mi = enemyMonster
		msw = $EnemyMonster/MonsterStatusWidget
	
	if mi:
		msw.get_node("HP").text = "%d/%d" % [mi.hp, mi.GetStat("hp")]
		msw.get_node("HPBar").max_value = mi.GetStat("hp")
		msw.get_node("HPBar").value = mi.hp
		# todo: make a script on MSW's and make a refresh function on it
	
	nextAction *= -1

func CheckForKO():
	if playerMonster.hp <= 0:
		return playerMonster
	elif enemyMonster.hp <= 0:
		return enemyMonster
	return false


func ActivateKO(mi):
	stage = BATTLE_STAGE.KO
	
	$Panel/Report.text = "%s has been knocked out!" % mi.species.name

func ProcessKO():
	if Input.is_action_just_pressed("interact"):
		ActivateConclude()


func ActivateConclude():
	if ko == playerMonster:
		$Panel/Report.text = "You have lost the battle!"
	elif ko == enemyMonster:
		$Panel/Report.text = "You have won the battle!"


func _on_fight_pressed():
	ActivateFight()

func _on_item_pressed():
	$Panel.SetText("Which Item to use?")
	$Panel/Fight.hide()
	$Panel/Party.hide()
	$Panel/Item.show()

func _on_switch_pressed():
	$Panel/Fight.hide()
	$Panel/Party.show()
	$Panel/Item.hide()
	$Panel.SetText("Switch to which Monster?")

func _on_flee_pressed():
	pass  # lock in Flee Action

func _on_move_pressed(m):
	var playerAction = MoveAction.new(
		playerMonster.moves[m],
		playerMonster.GetStat("speed"),
		playerMonster,
		enemyMonster
	)
	ConcludePoll(playerAction)
