extends Interaction
class_name Interaction_Action

@export var identity : String = "Name of Interaction" # Debug only
@export var button_label : String = "DO ACTION"
@export var sound: AudioStream

@export var repeatable : bool = false
@export var max_repeats : int = 0
@export var requires_item : String = ""
@export var button_actions: Array[Action]
@export var start_active : bool = true

var _button_actions: Array[Action]

var trigger_count: int = 0

func load_data(node_in):
	is_active = start_active
	for a in button_actions:
		_button_actions.append(a.duplicate(true))
	super(node_in)
		
func area_entered():
	if requires_item != "":
		if not Events.inventory.contains_by_name(requires_item):
			return
	super()
	
func get_is_active() -> bool:
	return is_active

func do_button_action(node):
	if requires_item != "":
		Events.emit_signal("use_inventory", requires_item)
	#Do connected Actions
	if len(_button_actions) > 0:
		for action in _button_actions:
			action._action(node)
	#Check if this should be disabled
	trigger_count += 1
	if max_repeats == -1:
		return
	if not repeatable or trigger_count >= max_repeats:
		set_active(false)
