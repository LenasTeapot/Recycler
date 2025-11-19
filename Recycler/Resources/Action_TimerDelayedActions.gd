extends Action
class_name Action_TimerDelayedActions

@export var timer_length : float
@export var actions : Array[Action]

var timer

func _action(node):
	print("Start Timer")
	timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = timer_length
	timer.timeout.connect(
		func(): 
			print("Timer done")
			do_actions_list(node)
			)
	node.add_child(timer)
	timer.start()
	#timer = Events.set_up_timer(null, timer_length, true, func(node): self.do_actions_list(node))
					
func do_actions_list(node):
	for a in actions:
		var new_a = a.duplicate(true)
		new_a._action(node)
