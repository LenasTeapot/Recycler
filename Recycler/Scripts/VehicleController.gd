extends Node3D

@export var path : PathFollow3D

var x_offset: float = 0
var y_offset: float = 0
var z_offset: float = 0

@export var Y_MINMAX = Vector2(0, 25)
@export var Z_MINMAX = Vector2(-30, 30)
@export var up_speed : float = 0.25
@export var side_speed : float = 0.25
@export var max_rot : float = 10.0

var y_ramp_up_mod = 0
var z_ramp_up_mod = 0
var sprint_multiplier = 1

const RAMP_INC = 0.05
const SPRINT_MAX = 2
	
func _ready():
	var curve = path.get_parent()
	if curve is Path3D:
		global_position = curve.global_position
		y_offset = position.y
		x_offset = position.x

func _process(_delta):
	# Sprint
	if Input.is_action_pressed("Sprint"):
		sprint_multiplier = clampf(sprint_multiplier + RAMP_INC, 1.0, SPRINT_MAX)
	else:
		sprint_multiplier = clampf(sprint_multiplier - RAMP_INC, 1.0, SPRINT_MAX)
		
	# Up Down
	if Input.is_action_pressed("Up"):
		y_ramp_up_mod = clampf(y_ramp_up_mod + RAMP_INC, -1.0, 1.0)
	elif Input.is_action_pressed("Down"):
		y_ramp_up_mod = clampf(y_ramp_up_mod - RAMP_INC, -1.0, 1.0)
	else:
		if y_ramp_up_mod > 0:
			y_ramp_up_mod = clampf(y_ramp_up_mod - RAMP_INC, 0, 1.0)
		else:
			y_ramp_up_mod = clampf(y_ramp_up_mod + RAMP_INC, -1.0, 0)
	
	# Left Right
	if Input.is_action_pressed("Left"):
		z_ramp_up_mod = clampf(z_ramp_up_mod - RAMP_INC, -1.0, 1.0)
	elif Input.is_action_pressed("Right"):
		z_ramp_up_mod = clampf(z_ramp_up_mod + RAMP_INC, -1.0, 1.0)
	else:
		if z_ramp_up_mod > 0:
			z_ramp_up_mod = clampf(z_ramp_up_mod - RAMP_INC, 0, 1.0)
		else:
			z_ramp_up_mod = clampf(z_ramp_up_mod + RAMP_INC, -1.0, 0)
		
	# Misc Inputs
	if Input.is_action_just_pressed("Select"):
		Events.emit_signal("select_ui")
	
	#POSITION
	y_offset = clamp(y_offset + (up_speed * y_ramp_up_mod * sprint_multiplier), Y_MINMAX.x, Y_MINMAX.y)
	z_offset = clamp(z_offset + (side_speed * z_ramp_up_mod * sprint_multiplier), Z_MINMAX.x, Z_MINMAX.y)

	path.progress_ratio = y_offset / Y_MINMAX.y
	x_offset = path.global_position.x
	
	position = Vector3(x_offset, y_offset, z_offset)
	
	#ROTATION
	var new_rot = lerp(0.0, max_rot, 0 - z_ramp_up_mod)
	%Mesh.rotation_degrees = Vector3(0.0, 0.0, new_rot)
