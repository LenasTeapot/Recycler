extends Node3D
	
@onready var audio_bg : AudioStreamPlayer = self.find_child("AudioStreamPlayer")
	
func _ready():
	if audio_bg != null and audio_bg.stream != null:
		audio_bg.play()
	
func _input(event):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	
