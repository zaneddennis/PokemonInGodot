extends Panel

@export var InventoryItemButton : PackedScene

#@export var player : Player

var lastCategory = ""


func _ready():
	for b in $Categories.get_children():
		b.pressed.connect(_on_category_pressed.bind(b.name))
	
	ActivateCategory("Item")


func Activate():
	if lastCategory:
		ActivateCategory(lastCategory)
	else:
		ActivateCategory("Item")
	
	$Description.text = ""
	visible = !visible


func ActivateCategory(c):
	for i in $Items/VBoxContainer.get_children():
		i.queue_free()
	
	var toDisplay = GameStatus.playerInventory.GetItems(Item.ITEM_TYPE[c.to_upper()])
	
	for i in toDisplay:
		var iib = InventoryItemButton.instantiate()
		$Items/VBoxContainer.add_child(iib)
		iib.Activate(i, toDisplay[i])
		iib.mouse_entered.connect(_on_item_highlighted.bind(i))


func ActivateItem(i):
	print("highlighting ", i)
	var iData = Database.GetItem(i)
	$Description.text = iData.description

func _on_category_pressed(b):
	ActivateCategory(b)

func _on_item_highlighted(i):
	ActivateItem(i)
