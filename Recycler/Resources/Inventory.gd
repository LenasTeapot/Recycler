extends Resource
class_name Inventory

@export var inventory: Array[Item_Resource]

func _init():
	pass

func add_item(item : Item_Resource):
	for entry in inventory:
		if entry.item_name == item.item_name:
			entry.count += 1
			return
	inventory.append(item)
	
func remove_item(item : Item_Resource):
	for entry in inventory:
		if entry.item_name == item.item_name:
			entry.count -= 1
			if entry.count == 0:
				inventory.erase(entry)
			return

func contains(item : Item_Resource):
	for entry in inventory:
		if entry.item_name == item.item_name:
			return true
	return false
	
func contains_by_name(item_name : String):
	for entry in inventory:
		if entry.item_name == item_name:
			return true
	return false
	
func get_count(item : Item_Resource):
	for entry in inventory:
		if entry.item_name == item.item_name:
			return entry.count
	return 0

func save_inventory():
	pass
	
func load_inventory():
	pass
