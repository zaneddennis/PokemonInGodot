extends Resource
class_name Party


@export var data: Array[MonsterInstance]


func GetMonsters():
	return data


func AddMonster(mi):
	data.append(mi)

# ???
#func RemoveMonster():
#	pass


func RestoreAll():
	for mi in data:
		mi.FullRestore()


func ToStr():
	#return str(data)
	var result = []
	for mi in data:
		result.append(str(mi))
	return str(result)

func FromStr(d):
	data.clear()
	
	d = JSON.parse_string(d)
	for miStr in d:
		data.append(MonsterInstance.FromStr(miStr))
