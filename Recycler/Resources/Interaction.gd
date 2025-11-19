extends Resource
class_name Interaction

enum EPOPUP_TYPE {
	SPEECH_BUBBLE = 0,
	BUTTON
}

enum EPOPUP_SIDE {
	RIGHT = 0,
	CENTER,
	LEFT
}

const pop_up_map = {
	EPOPUP_TYPE.SPEECH_BUBBLE : {
		EPOPUP_SIDE.RIGHT : "res://Scenes/PopUps/SpeechBubble.tscn",
		EPOPUP_SIDE.CENTER : "res://Scenes/PopUps/SpeechBubble_Center.tscn",
		EPOPUP_SIDE.LEFT : "res://Scenes/PopUps/SpeechBubble_Left.tscn",
	},
	EPOPUP_TYPE.BUTTON : {
		EPOPUP_SIDE.RIGHT : "res://Scenes/PopUps/InteractableButton.tscn",
		EPOPUP_SIDE.CENTER : "res://Scenes/PopUps/InteractableButton_Center.tscn",
		EPOPUP_SIDE.LEFT : "res://Scenes/PopUps/InteractableButton_Left.tscn",
	}
}

@export_category("Interaction")
@export var pop_up_side : EPOPUP_SIDE
@export var triggerable_actions : Array[TriggerableAction]
@export var active_actions : Array[Action]
@export var inactive_actions : Array[Action]

var pop_up_type : EPOPUP_TYPE = EPOPUP_TYPE.BUTTON
var pop_up_class
var my_node
var button_action: Callable = do_button_action
var is_active : bool = true
var _triggerable_actions : Array[TriggerableAction] # Due to bug in the way non-static arrays are copied

func load_data(node_in):
	pop_up_class = pop_up_map[pop_up_type][pop_up_side]
	my_node = node_in
	
	for t in triggerable_actions:
		_triggerable_actions.append(t._duplicate())
	
	for ta in _triggerable_actions:
		Events.connect("quest_complete", 
		func(quest):
			if quest == ta.trigger:
				for a in ta.actions:
					a._action(my_node)
			)
	
func area_entered():
	Events.emit_signal("ui_open", my_node, pop_up_class)
		
func area_exited():
	Events.emit_signal("ui_close", my_node)
	
func do_button_action(node):
	pass
	
func set_active(is_active_in):
	#print("Set Active ", my_node.name, " ", is_active_in)
	is_active = is_active_in
	if my_node == null:
		return
	my_node.area.monitoring = is_active
	
	if is_active:
		for a in active_actions:
			a._action(my_node)
	else:
		for a in inactive_actions:
			a._action(my_node)
