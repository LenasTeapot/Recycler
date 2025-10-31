extends Action
class_name Action_MeshSwap

@export var secondary_mesh : Mesh

func _action(node):
	super(node)
	if node is MeshInstance3D:
		node.mesh = secondary_mesh
	#TODO : Try to find a child node of the right type
