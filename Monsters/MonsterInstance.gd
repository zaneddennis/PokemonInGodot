extends Resource
class_name MonsterInstance

# biography
@export var species: Monster
@export var xp = 0

# status
@export var hp = 0
@export var conditions = []
@export var moves: Array[Move]


static func New(spName, xp=0, hp=null):
	var mi = MonsterInstance.new()
	
	var sp = Database.GetMonster(spName)
	mi.species = sp
	
	mi.xp = xp
	var level = mi.GetLevel()
	
	if hp:
		mi.hp = hp
	else:
		mi.hp = mi.GetStat("hp")
	
	for l in range(level+1):
		if l in mi.species.move_table:
			mi.moves.append(mi.species.move_table[l])
	
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
	return result + 10


func _to_string():
	return "<MonsterInstance:%s:L%d:H%d>" % [species.name, GetLevel(), hp]

static func FromStr(s):
	var data = s.left(-1).right(-1).split(":")
	var mi = MonsterInstance.New(data[1])
	return mi
