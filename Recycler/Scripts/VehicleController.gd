extends Node3D

@export var path : PathFollow3D

var x_offset: float = 0
var y_offset: float = 0
var z_offset: float = 0

var Y_MINMAX = Vector2(0, 25)
var Z_MINMAX = Vector2(-30, 30)
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
		z_offset -= 1 * side_speed
	if Input.is_action_pressed("Right"):
		z_offset += 1 * side_speed
	if Input.is_action_just_pressed("Select"):
		Events.emit_signal("select_ui")
		
	y_offset = clamp(y_offset, Y_MINMAX.x, Y_MINMAX.y)
	position.y = y_offset
	
	z_offset = clamp(z_offset, Z_MINMAX.x, Z_MINMAX.y)
	position.z = z_offset
	
	path.progress_ratio = y_offset / Y_MINMAX.y
	x_offset = path.global_position.x
	position.x = x_offset
	
