extends Button


@export var item: String
@export var quantity: int


func Activate(i, q):
	item = i
	quantity = q
	
	text = "%dx %s" % [q, i.capitalize()]
