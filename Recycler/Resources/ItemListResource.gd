extends Resource
class_name ItemListResource

#Items
@export var items_list: Array[Item_Resource]

func get_trash(num: int):
	var trash = []
	while len(trash) < num:
		var item : Item_Resource = items_list.pick_random()
		if item.unique and item.in_inventory:
			continue
		trash.append(item.item_name)
		item.in_inventory = true
	return trash
	
func add_item(item: Item_Resource):
	items_list.append(item)

	
