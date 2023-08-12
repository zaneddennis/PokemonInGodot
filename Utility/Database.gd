extends Node


@export_dir var itemDataDir: String

var items = {}


func _ready():
	LoadData()


func GetItem(i):
	return items[i]


func LoadData():
	LoadItems()
	# Load Monsters
	# etc


func LoadItems():
	print("Loading Item data...")
	var dir = DirAccess.open(itemDataDir)
	if dir:
		for p in dir.get_files():
			var data = load("res://Items/ItemData/" + p)
			items[p.get_basename()] = data
		print("Item data loaded!")
	else:
		print("ERROR: failed to load Item data")
