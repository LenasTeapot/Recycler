extends Node

var inventory #HACK : Ugh

signal ui_open
signal ui_close
signal select_ui

signal trash_collected
signal take_inventory
signal use_inventory
signal check_inventory
signal add_item_to_possible_trash

signal quest_complete


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
