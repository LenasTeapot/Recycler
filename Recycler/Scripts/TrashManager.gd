extends Node
class_name TrashManager

var inactive_points = []
var active_points = []
#Items
@onready var items_list : ItemListResource = load("res://Resources/ItemsList.tres") # TODO : SERIALIZE

#Timers
var timer := Timer.new()
var WAIT_TIME = 5.0
var POST_PICKUP_WAIT_TIME = 9.0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("TRASH MANAGER")
	inactive_points = get_tree().get_nodes_in_group("PickUp")
	for point in inactive_points:
		point.set_active(false)
	Events.connect("trash_collected", _on_trash_collected)
	Events.connect("add_item_to_possible_trash", _on_add_item_to_list)
	items_list = items_list.duplicate()
	Events.set_up_timer(timer, WAIT_TIME, false, on_timeout)
	
func _on_add_item_to_list(item : Item_Resource):
	items_list.add_item(item)
	
func _process(_delta):
	# Sprint
	if Input.is_action_just_pressed("Cheat"):
		add_trash()
		
func add_trash():
	### TODO Move this to inventory
	var new_trash = items_list.get_trash(randi_range(1, 4))
	Events.emit_signal("take_inventory", new_trash)
	
func _on_trash_collected(point):
	add_trash()
	
	if point == null:
		return
	point.set_active(false)
	if active_points.has(point):
		active_points.erase(point)
		Events.set_up_timer(null, POST_PICKUP_WAIT_TIME, true, 
					func(): inactive_points.append(point))
		
func on_timeout():
	if len(inactive_points) > 0:
		var new = inactive_points.pick_random()
		inactive_points.erase(new)
		active_points.append(new)
		new.set_active(true)
