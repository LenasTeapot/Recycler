extends Action
class_name Action_TriggerQuestComplete

@export var trigger_on_complete: String

func _action(node):
	if trigger_on_complete != "":
		Events.emit_signal("quest_complete", trigger_on_complete)
