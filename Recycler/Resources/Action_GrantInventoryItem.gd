extends Action
class_name Action_GrantInventoryItem

@export var unique_items : Array[Item_Resource]

func _action(node):
	super(node)
	Events.emit_signal("take_inventory", unique_items)
