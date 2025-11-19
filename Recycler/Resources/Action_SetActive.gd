extends Action
class_name Action_SetActive

@export var override_active : bool

func _action(node):
	node.set_active(override_active)
