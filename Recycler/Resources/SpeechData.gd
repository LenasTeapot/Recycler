extends Resource

class_name SpeechData

var dict = {}
@export var data : Array[Step] :
	get:
		return data
	set(value):
		data = value
		set_up()


func _init():
	Events.connect("quest_complete", _on_quest_complete)
	
func set_up():
	for item in data:
		dict[item.trigger] = item
	print(dict)
	
func get_current_line():
	for item in dict:
		if dict[item].complete == false:
			return dict[item].line
	return ""

func _on_quest_complete(quest):
	if dict.has(quest):	
		dict[quest].complete = true
