extends Resource
class_name MonsterInstance

# biography
@export var species: Monster
@export var xp = 0

# status
@export var hp = 0
@export var conditions = []
@export var moves: Array[Move]


static func New(spName, hp=null):
	var mi = MonsterInstance.new()
	
	var sp = Database.GetMonster(spName)
	mi.species = sp
	
	if hp:
		hp = hp
	else:
		hp = mi.GetStat("hp")
	return mi


func ApplyDamage(d):
	hp = max((hp - d), 0)

func FullRestore():
	hp = GetStat("hp")
	conditions = []


func GetLevel():
	return floor(1 + sqrt(xp) / Constants.MAX_LEVEL)

static func GetXPAt(level):
	return 100 * pow(level - 1, 2)

# XP required to go from current level to next level
func GetXPRequired():
	var curr = GetXPAt(GetLevel())
	var next = GetXPAt(GetLevel() + 1)
	return next - curr

# "current" XP over the current level
func GetXPModulo():
	return xp - GetXPAt(GetLevel())

func GetStat(s):
	var result = floor(species.get(s) * GetLevel() / Constants.MAX_LEVEL)
	if s == "hp":
		result += 10
	return result


func _to_string():
	return "<MonsterInstance:%s:%d>" % [species.name, hp]

static func FromStr(s):
	var data = s.left(-1).right(-1).split(":")
	var mi = MonsterInstance.New(data[1])
	return mi
