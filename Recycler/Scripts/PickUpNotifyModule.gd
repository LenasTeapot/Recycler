extends Node3D

const pop_up_class = "res://UI/PickUpAltert_UI.tscn"
@onready var notifier : VisibleOnScreenNotifier3D = $VisibleOnScreenNotifier3D

func _ready():
	if not notifier:
		printerr("No notifier found on ", name)
		notifier = get_child(0)
	Events.set_up_timer(null, 0.01, true, func():
		notifier.screen_entered.connect(_on_screen_entered)
		notifier.screen_exited.connect(_on_screen_exited)
		)
	
func _on_screen_entered():
	Events.emit_signal("ui_close", self)

func _on_screen_exited():
	if is_queued_for_deletion() or not visible:
		return
	Events.emit_signal("ui_open", self, pop_up_class)

func _on_visibility_changed():
	if not visible:
		Events.emit_signal("ui_close", self)
	if not notifier.is_on_screen() and visible:
		_on_screen_exited()
