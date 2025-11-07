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
		if item.trigger == "":
			item.complete = true
	
func get_current_line():
	var line = ""
	for item in dict:
		if dict[item].complete == true:
			line = dict[item].line
	return line

func _on_quest_complete(quest):
	if dict.has(quest):	
		dict[quest].complete = true
