extends MeshInstance3D

@export var interaction: Interaction

@onready var area: Area3D = $Interactable_Area3D

func _ready():
	if interaction != null:
		interaction.load_data(self)
		check_active()

func _on_area_3d_area_entered(area_in):
	if area_in.name == area.name:
		return
	if interaction == null:
		return
		
	interaction.area_entered()

func _on_area_3d_area_exited(area_in):
	if area_in.name == area.name:
		return
	if interaction == null:
		return
	interaction.area_exited()
	
func get_pop_up_class():
	return interaction.pop_up_class
	
func check_active():
	if interaction.get("is_active") != null:
		set_active(interaction.is_active)

func set_active(active_in):
	if interaction == null:
		printerr("This node has no interaction to set active.")
		return
	if interaction.has_method("set_active"):
		interaction.set_active(active_in)
		
func get_speech_data():
	if interaction == null:
		printerr("This node has no speech data to retrieve.")

	return interaction.get("speech_data")

