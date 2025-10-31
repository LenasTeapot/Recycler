extends CanvasLayer

#TODO: Set up inventory as a resource so we can save/load it?
@onready var inventory := Inventory.new()
@onready var container = $Panel/MarginContainer/GridContainer
var label_scene = "res://Scenes/InventoryLabel.tscn"
var labels = {}

###This class directs calls to the Inventory class and updates the UI

func _ready():
	Events.inventory = inventory
	Events.connect("take_inventory", _on_take_inventory)
	Events.connect("use_inventory", _on_use_inventory)
	
func _on_take_inventory(trash):
	for item in trash:
		inventory.add_item(item)
		update_item_label(item)
	
func _on_use_inventory(item):
	#Update Inventory first
	inventory.remove_item(item)
	#If item gone, remove it
	if not inventory.contains(item):
		remove_item_label(item)
	#Otherwise update with new count
	else:
		update_item_label(item)
	
func update_item_label(item):
	if labels.has(item):
		labels[item].update(item, inventory.get_count(item))
	else:
		var new_label = load(label_scene).instantiate()
		container.add_child(new_label)
		labels[item] = new_label
		new_label.set_up(item)
	
func remove_item_label(item):
	var label = labels[item]
	label.remove_ui(func(): label.queue_free())
	labels.erase(item)

