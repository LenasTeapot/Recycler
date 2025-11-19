extends Interaction
class_name  Interaction_Speech

var dict = {}

@export var identity : String = "Name of Person" # Debug only
@export var speech_data : Array[Step] :
	
	get:
		return speech_data
	set(value):
		speech_data = value
		set_up()

func load_data(node_in):
	pop_up_type = EPOPUP_TYPE.SPEECH_BUBBLE
	super(node_in)
	Events.connect("quest_complete", _on_quest_complete)
	
func set_up():
	for item in speech_data:
		dict[item.trigger] = item
		if item.trigger == "":
			item.complete = true
	
func get_current_line():
	var line = ""
	for item in dict:
		if dict[item].complete == true:
			line = dict[item].line
	return line

func _on_quest_complete(quest):
	if dict.has(quest):	
		dict[quest].complete = true
		
func area_entered():
	if len(speech_data) > 0 and speech_data != null and my_node.visible == true:
		super()
