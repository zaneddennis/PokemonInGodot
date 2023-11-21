extends Node


func WeightedRandomChoice(d: Dictionary):
	assert(len(d) > 0)
	
	var total = 0.0
	for v in d.values():
		assert(v > 0.0)
		total += v
	
	var roll = randf_range(0.0, total)
	
	var target = 0.0
	for k in d:
		target += d[k]
		if roll <= target:
			return k
	
	assert(false)  # if this is ever reached, I did something wrong
