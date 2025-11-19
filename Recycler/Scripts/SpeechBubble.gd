extends PopUp

var font_min = 16.0
var font_max = 45.0

func _ready():
	element = $Label
	super()

func load_data(node_in):
	super(node_in)
	var data = my_node.interaction
	if data != null:
		element.text = data.get_current_line()
	element.name = "speech_bubble"
