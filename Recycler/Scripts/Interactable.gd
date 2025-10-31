extends MeshInstance3D

@export var interaction: Interaction
@export_file var pop_up_class
@export var speech_data : SpeechData
@onready var area: Area3D = $Interactable_Area3D
var is_active : bool

func _on_area_3d_area_entered(area_in):
	print(area_in)
	if area_in.name == area.name:
		return
	if not interaction:
		Events.emit_signal("ui_open", self)
		return
	if interaction.requires_item != "":
		if Events.inventory.contains(interaction.requires_item):
			Events.emit_signal("ui_open", self)
	else:
		Events.emit_signal("ui_open", self)

func _on_area_3d_area_exited(area_in):
	if area_in.name == area.name:
		return
	Events.emit_signal("ui_close", self)
	
func set_active(is_active_in):
	#print("set active : ", is_active_in, " on node ", name)
	is_active = is_active_in
	area.monitoring = is_active
	if interaction.hide_when_inactive:
		visible = is_active
	
func complete():
	set_active(false)
	if interaction.requires_item != "":
		Events.emit_signal("use_inventory", interaction.requires_item)
	if interaction.hide_on_complete:
		visible = false
		
func activate(quest):
	if interaction.activate_trigger != "" and quest == interaction.activate_trigger:
		set_active(true)
	
func get_is_active() -> bool:
	return is_active

func _ready():
	if not interaction:
		print("No interaction listed")
		return
		
	#Signals
	if interaction.activate_trigger != "":
		Events.connect("quest_complete", activate)
	interaction.complete_signal.connect(func(): complete())
	
	#Start up state
	if interaction.activate_trigger == "":
		set_active(true)
	else:
		set_active(false)
