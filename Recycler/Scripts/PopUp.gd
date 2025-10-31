extends Node2D
class_name PopUp

var element
var my_node : Node3D

func _ready():
	element.scale = Vector2()
	var tween = get_tree().create_tween()
	tween.tween_property(
		element, "scale", Vector2(1, 1), 0.35).set_trans(Tween.TRANS_BACK)

func _process(delta):
	position = get_viewport().get_camera_3d().unproject_position(my_node.position)
	position.y -= get_viewport_rect().size.y/2

func load_data(node_in):
	pass
	
func on_close(callback : Callable):
	if get_tree():
		var close_tween = get_tree().create_tween()
		close_tween.tween_property(
			element, "scale", Vector2(0, 0), 0.2).set_trans(Tween.TRANS_BACK)
		close_tween.tween_callback(callback)
