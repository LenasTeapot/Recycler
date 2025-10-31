extends Path3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var follow = get_child(0)
	follow.loop = true
