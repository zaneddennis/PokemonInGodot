extends Panel


var texts = []
var currentIx = -1


func Next():
	currentIx += 1
	
	if currentIx >= len(texts):
		pass  # deactivate
