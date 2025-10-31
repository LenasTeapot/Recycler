extends CanvasLayer

var current_interactables = {}
var draw_debugs = true

func _ready():
	Events.connect("ui_open", _on_ui_open)
	Events.connect("ui_close", _on_ui_close)
	Events.connect("select_ui", _on_select)
	
func _on_ui_open(node):
	if node:
		print("open ui")
	else:
		print("No node")
	var instance = load(node.pop_up_class).instantiate()
	add_child(instance)
	current_interactables[node] = instance
	instance.load_data(node)
	
func _on_ui_close(node):
	if current_interactables.has(node):
		current_interactables[node].on_close(func(): kill_ui(node))
		
func kill_ui(node):
	current_interactables[node].queue_free()
	current_interactables.erase(node)
	
func _on_select():
	for key in current_interactables:
		var inter = current_interactables[key]
		if inter.has_method("_on_pressed"):
			inter._on_pressed()
			return
