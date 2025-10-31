extends PopUp

func _ready():
	element = $Label
	super()

func load_data(node_in):
	my_node = node_in
	if my_node.speech_data:
		element.text = my_node.speech_data.get_current_line()
	element.name = "speech_bubble"
