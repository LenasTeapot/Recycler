extends Action
class_name Action_CountQuest

@export var quest_to_count : String
@export var number_to_complete : int
@export var completed_actions : Array[Action]

var current_count : int = 0
var is_complete : bool = false

func _action(node):
	current_count += 1
	print("Count up ", node.name, " to ", current_count)
	if current_count >= number_to_complete and not is_complete:
		is_complete = true
		print("CountQuest complete : ", node.name)
		for a in completed_actions:
			a._action(node)

