extends Resource
class_name Interaction

@export_category("Interactable Data")
#Do not rely on this variable for anything other than debugging
@export var identity : String = "Name of Interaction"
@export var button_label : String = "DO ACTION"

@export var repeatable : bool = false
@export var max_repeats : int = 0
@export var hide_on_complete : bool = false
@export var hide_when_inactive : bool = false
@export var activate_trigger : String = ""
@export var requires_item : String = ""
@export var action_resourse: Array[Action]
@export var sound: AudioStream

signal complete_signal 
var action: Callable = do_action
var trigger_count: int = 0

#TODO: Could make this a further resource by type?
func do_action(node):
	#Do connected Actions
	if len(action_resourse) > 0:
		for action in action_resourse:
			action._action(node)
	#Check if this should be disabled
	trigger_count += 1
	if max_repeats == -1:
		return
	if not repeatable:
		complete_signal.emit()
		return
	if trigger_count >= max_repeats:
		complete_signal.emit()
