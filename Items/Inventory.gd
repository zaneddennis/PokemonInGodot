extends Resource
class_name Inventory


@export var data: Dictionary


func AddItem(item, q):
	if item in data:
		data[item] += q
	else:
		data[item] = q


func GetItems(itemType):
	var result = {}
	
	for i in data:
		var iData = Database.GetItem(i)
		if iData.itemType == itemType:
			result[i] = data[i]
	
	return result


func RemoveItem(item):
	assert(item in data)
	
	if data[item] == 1:
		data.erase(item)
	else:
		data[item] -= 1


func ToStr():
	return str(data)

func FromStr(d):
	print(d)
	d = JSON.parse_string(d)
	data = d
