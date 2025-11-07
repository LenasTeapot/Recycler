extends Node2D
class_name PopUp

var element
var my_node
var offset_y : float = 0.0

func _ready():
	element.scale = Vector2()
	var tween = get_tree().create_tween()
	tween.tween_property(
		element, "scale", Vector2(1, 1), 0.45).set_trans(Tween.TRANS_BACK)

func _process(delta):
	position = get_viewport().get_camera_3d().unproject_position(Vector3(my_node.global_position.x, my_node.global_position.y + offset_y, my_node.global_position.z))

func load_data(node_in):
	my_node = node_in
	if node_in is MeshInstance3D:
		var bounds = node_in.mesh.get_aabb();
		offset_y = bounds.size.y * my_node.scale.y
	
func on_close(callback : Callable):
	if get_tree():
		var close_tween = get_tree().create_tween()
		close_tween.tween_property(
			element, "scale", Vector2(0, 0), 0.2).set_trans(Tween.TRANS_BACK)
		close_tween.tween_callback(callback)
