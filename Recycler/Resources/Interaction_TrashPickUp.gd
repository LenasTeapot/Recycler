extends Interaction
class_name Interaction_TrashPickUp

###TODO: Can this be replaced with Interaction_Action?

@export_category("Trash Pick Up")
@export var identity : String = "Name of Interaction" # Debug only
@export var button_label : String = "DO ACTION"
@export var sound: AudioStream
@export var action_resourse: Array[Action]

func load_data(node_in):
	#print("Trash pick up point ", node_in.global_position, " ", node_in.name)
	super(node_in)

func do_button_action(node):
	if len(action_resourse) > 0:
		for action in action_resourse:
			action._action(node)
