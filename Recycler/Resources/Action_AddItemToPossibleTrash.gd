extends Action
class_name Action_AddItemToPossibleTrash

@export var item_to_add : Item_Resource

func _action(node):
	super(node)
	Events.emit_signal("add_item_to_possible_trash", item_to_add)
