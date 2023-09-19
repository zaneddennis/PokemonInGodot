extends Node


@export_dir var itemDataDir: String
@export_dir var monsterDataDir: String

var items = {}
var monsters = {}


func _ready():
	LoadData()


func GetItem(i):
	return items[i]

func GetMonster(m):
	return monsters[m]


func LoadData():
	LoadItems()
	LoadMonsters()


func LoadItems():
	print("Loading Item data...")
	var dir = DirAccess.open(itemDataDir)
	if dir:
		for p in dir.get_files():
			var data = load("res://Items/ItemData/" + p)
			items[p.get_basename()] = data
		print("\tItem data loaded! %d Items." % len(items))
	else:
		print("\tERROR: failed to load Item data")

func LoadMonsters():
	print("Loading Monster data...")
	var dir = DirAccess.open(monsterDataDir)
	if dir:
		for p in dir.get_files():
			var data = load("res://Monsters/MonsterData/" + p)
			monsters[p.get_basename()] = data
		print("\tMonster data loaded! %d Monsters." % len(monsters))
	else:
		print("\tERROR: failed to load Monster data")
