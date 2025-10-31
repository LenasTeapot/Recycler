extends Action
class_name Action_TrashCollect


func _action(node):
	super(node)
	Events.emit_signal("trash_collected", node)
