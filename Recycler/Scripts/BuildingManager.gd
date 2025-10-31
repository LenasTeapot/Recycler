extends Node3D

#Tennants
@export_node_path var pickup_points
@onready var inactive_points = get_node(pickup_points).get_children()
var active_points = []

#Items
@export var items_list : ItemListResource

#Timers
var timer := Timer.new()
var WAIT_TIME = 3.0
var POST_PICKUP_WAIT_TIME = 6.0

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.connect("trash_collected", _on_trash_collected)
	Events.connect("add_item_to_possible_trash", _on_add_item_to_list)
	items_list = items_list.duplicate()
	set_up_timer(timer, WAIT_TIME, false, on_timeout)
	on_timeout()
	
func _on_add_item_to_list(item : Item_Resource):
	items_list.add_item(item)
	
func _on_trash_collected(point):
	point.set_active(false)
	if active_points.has(point):
		active_points.erase(point)
		var new_trash = items_list.get_trash(randi_range(1, 3))
		print(new_trash)
		Events.emit_signal("take_inventory", new_trash)
		set_up_timer(null, POST_PICKUP_WAIT_TIME, true, 
					func(): inactive_points.append(point))
		
func on_timeout():
	if len(inactive_points) > 0:
		var new = inactive_points.pick_random()
		inactive_points.erase(new)
		active_points.append(new)
		new.set_active(true)


func set_up_timer(timer_in: Timer, 
					wait_time: float, 
					one_shot: bool, 
					on_finished: Callable):
	if not timer_in:
		timer_in = Timer.new()
	add_child(timer_in)
	timer_in.timeout.connect(on_finished)
	timer_in.wait_time = wait_time
	timer_in.one_shot = one_shot
	timer_in.start()
