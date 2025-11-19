extends Resource
class_name TriggerableAction
	
@export var trigger : String = ""
@export var actions : Array[Action]

func _duplicate():
	var new_actions : Array[Action]
	for a in actions:
		new_actions.append(a.duplicate(true))
	var new_ta = TriggerableAction.new()
	new_ta.trigger = trigger
	new_ta.actions = new_actions
	return new_ta
