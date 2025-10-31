extends Node3D
	
func _input(event):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
	
