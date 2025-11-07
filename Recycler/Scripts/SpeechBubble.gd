extends PopUp

var font_min = 16.0
var font_max = 45.0

func _ready():
	element = $Label
	super()

func load_data(node_in):
	super(node_in)
	if my_node.speech_data:
		element.text = my_node.speech_data.get_current_line()
	element.name = "speech_bubble"
