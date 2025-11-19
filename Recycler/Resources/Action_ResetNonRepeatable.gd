extends Action
class_name Action_ResetNonRepeatable

@export var set_to_active : bool = true

func _action(node):
	if node.interaction != null:
		if node.interaction.get("trigger_count") != null:
			node.interaction.set("trigger_count", 0)
	if set_to_active:
		node.set_active(true)
