extends Action
class_name Action_UpdateTransforms

@export var new_position := Vector3.ZERO
@export var new_rotation := Vector3.ZERO
@export var new_scale := Vector3.ONE

func _action(node):
	super(node)
	node.set_position(new_position)
	node.set_rotation(new_rotation)
	node.set_scale(new_scale)
