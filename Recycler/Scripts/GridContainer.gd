@tool
extends GridContainer

@export var horizontal_padding: int = 1:
	get:
		return horizontal_padding
	set(value):
		horizontal_padding = value
		#self.h_separation = value

@export var vertical_padding: int = 1:
	get:
		return vertical_padding
	set(value):
		vertical_padding = value
		#self.v_separation = value

