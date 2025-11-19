extends Action
class_name Action_SetVisible

@export_category("Set Visible - NOT ACTIVE")
@export var override_visible : bool
@export var set_children_to_match : bool = true

func _action(node):
	node.set_visible(override_visible)
	if set_children_to_match:
		var children = node.find_children("*", "", true)
		for c in children:
			c.set_visible(override_visible)
	
