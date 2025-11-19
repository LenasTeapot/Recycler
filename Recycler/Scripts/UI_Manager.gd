extends CanvasLayer

var current_popups = {}
# current_popups[node who sent ui] = instance of that pop up

const alert_icon = "res://UI/PickUpAltert_UI.tscn"

@export var draw_debugs = true

func _ready():
	Events.connect("ui_open", _on_ui_open)
	Events.connect("ui_close", _on_ui_close)
	Events.connect("select_ui", _on_select)
	
func _on_ui_open(node, pop_up_class):
	if not node or pop_up_class == null:
		printerr("No node given for this UI popup")
		return
	if pop_up_class == null or pop_up_class == "":
		printerr("pop up class is null")
		return
	var instance = load(pop_up_class).instantiate()
	add_child(instance)
	current_popups[node] = instance
	instance.load_data(node)
	
func _on_ui_close(node):
	if current_popups.has(node):
		current_popups[node].on_close(func(): kill_ui(node))
		
func kill_ui(node):
	current_popups[node].queue_free()
	current_popups.erase(node)
	
func _on_select():
	for key in current_popups:
		var instance = current_popups[key]
		if instance.has_method("_on_pressed"):
			instance._on_pressed()
			return
