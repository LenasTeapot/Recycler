extends Node3D
	
@onready var audio_bg : AudioStreamPlayer = self.find_child("AudioStreamPlayer")

var trash_manager : TrashManager

# TODO : Serialization
	
func _ready():
	trash_manager = TrashManager.new()
	add_child(trash_manager)
	
	if audio_bg != null and audio_bg.stream != null:
		audio_bg.play()
	
func _input(_event):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("Cheat"):
		Events.emit_signal("trash_collected", null)
	
