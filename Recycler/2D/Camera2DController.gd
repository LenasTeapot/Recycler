extends Node2D

var x_offset: float = 0
var y_offset: float = 0

@export var Y_MINMAX = Vector2(0, 25)
@export var X_MINMAX = Vector2(-30, 30)
@export var up_speed: float = 0.25
@export var side_speed: float = 0.25

var y_ramp_up_mod = 0
var x_ramp_up_mod = 0
var sprint_multiplier = 1

const RAMP_INC = 0.05
const SPRINT_MAX = 2

func _process(delta):
	# Sprint
	if Input.is_action_pressed("Sprint"):
		sprint_multiplier = clampf(sprint_multiplier + RAMP_INC, 1.0, SPRINT_MAX)
	else:
		sprint_multiplier = clampf(sprint_multiplier - RAMP_INC, 1.0, SPRINT_MAX)
		
	# Up Down
	if Input.is_action_pressed("Up"):
		y_ramp_up_mod = clampf(y_ramp_up_mod - RAMP_INC, -1.0, 1.0)
	elif Input.is_action_pressed("Down"):
		y_ramp_up_mod = clampf(y_ramp_up_mod + RAMP_INC, -1.0, 1.0)
	else:
		if y_ramp_up_mod > 0:
			y_ramp_up_mod = clampf(y_ramp_up_mod - RAMP_INC, 0, 1.0)
		else:
			y_ramp_up_mod = clampf(y_ramp_up_mod + RAMP_INC, -1.0, 0)
	
	# Left Right
	if Input.is_action_pressed("Left"):
		x_ramp_up_mod = clampf(x_ramp_up_mod - RAMP_INC, -1.0, 1.0)
	elif Input.is_action_pressed("Right"):
		x_ramp_up_mod = clampf(x_ramp_up_mod + RAMP_INC, -1.0, 1.0)
	else:
		if x_ramp_up_mod > 0:
			x_ramp_up_mod = clampf(x_ramp_up_mod - RAMP_INC, 0, 1.0)
		else:
			x_ramp_up_mod = clampf(x_ramp_up_mod + RAMP_INC, -1.0, 0)
		
	# Misc Inputs
	if Input.is_action_just_pressed("Select"):
		Events.emit_signal("select_ui")
	
	
	y_offset = clamp(y_offset + (side_speed * y_ramp_up_mod * sprint_multiplier), Y_MINMAX.x, Y_MINMAX.y)
	x_offset = clamp(x_offset + (up_speed * x_ramp_up_mod * sprint_multiplier), X_MINMAX.x, X_MINMAX.y)
	
	position.x = x_offset
	position.y = y_offset
