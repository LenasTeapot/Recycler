extends Node3D

var y_offset: float = 0
var x_offset: float = 0

var Y_MINMAX = Vector2(0, 25)
var X_MINMAX = Vector2(-30, 30)
var up_speed: float = 0.25
var side_speed: float = 0.25

func _process(delta):
	if Input.is_action_pressed("Sprint"):
		up_speed += 0.05
		side_speed += 0.05
	if Input.is_action_pressed("Up"):
		y_offset += 1 * up_speed
	if Input.is_action_pressed("Down"):
		y_offset -= 1 * up_speed
	if Input.is_action_pressed("Left"):
		x_offset -= 1 * side_speed
	if Input.is_action_pressed("Right"):
		x_offset += 1 * side_speed
	if Input.is_action_just_pressed("Select"):
		Events.emit_signal("select_ui")
		
	y_offset = clamp(y_offset, Y_MINMAX.x, Y_MINMAX.y)
	position.y = y_offset
	
	x_offset = clamp(x_offset, X_MINMAX.x, X_MINMAX.y)
	position.z = x_offset
