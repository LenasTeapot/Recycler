extends PopUp

var player
var vp_player_pos


func _ready():
	element = $Sprite2D
	player = get_tree().get_first_node_in_group("Player")
	vp_player_pos = get_viewport().get_camera_3d().unproject_position(Vector3(player.global_position))
	super()
	
func load_data(node):
	my_node = node.get_parent()
	
func _process(delta):
	if my_node == null:
		return

	var vp_size = get_viewport().size
	var vp_pos = get_viewport().get_camera_3d().unproject_position(my_node.global_position)
	
	var sprite_size = element.get_rect().size
	
	var x_norm = clamp(vp_pos.x, sprite_size.x/2, vp_size.x - sprite_size.x/2)
	var y_norm = clamp(vp_pos.y,  sprite_size.y/2, vp_size.y - sprite_size.y/2)

	position = Vector2(x_norm, y_norm)
