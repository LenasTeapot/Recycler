extends Resource
class_name Inventory

@export var inventory: Array[Item_Resource]

func _init():
	pass

func add_item(item):
	for entry in inventory:
		if entry.item_name == item:
			entry.count += 1
			return
	var new_res = Item_Resource.new()
	new_res.item_name = item
	new_res.count = 1
	inventory.append(new_res)
	
func remove_item(item):
	for entry in inventory:
		if entry.item_name == item:
			entry.count -= 1
			if entry.count == 0:
				inventory.erase(entry)
			return

func contains(item):
	for entry in inventory:
		if entry.item_name == item:
			return true
	return false
	
func get_count(item):
	for entry in inventory:
		if entry.item_name == item:
			return entry.count
	return 0

func save_inventory():
	pass
	
func load_inventory():
	pass
