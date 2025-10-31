extends PopUp
class_name InteractableButton

var interaction : Interaction
var wiggle_tween : Tween
const wiggle_amount = 2.0
const wiggle_time = 0.2

func _ready():
	element = $Button
	super()

func _on_pressed():
	interaction.action.call(my_node)
	bounce()
	#On close will get called when leaving area

func load_data(node_in):
	interaction = node_in.interaction
	my_node = node_in
	element.text = interaction.button_label
	name = interaction.identity
	element.connect("pressed", _on_pressed)

func _on_mouse_entered():
	wiggle(0)
	
func _on_mouse_exited():
	element.scale = Vector2(1.0, 1.0)
	element.rotation_degrees = 0.0
	wiggle_tween.kill()

func bounce():
	var bounce_tween = get_tree().create_tween()
	var start_pos = element.position
	element.position = Vector2(start_pos.x, start_pos.y - 10)
	bounce_tween.tween_property(element, "position", start_pos, 0.5).set_trans(Tween.TRANS_BACK)

func wiggle(repeats: int):
	element.scale = Vector2(1.05, 1.05)
	element.rotation_degrees = wiggle_amount
	wiggle_tween = get_tree().create_tween().set_loops(repeats)
	wiggle_tween.tween_property(
		element, "rotation_degrees", 0 - wiggle_amount, wiggle_time).from(wiggle_amount).set_trans(
			Tween.TRANS_QUART)
	wiggle_tween.tween_property(
		element, "rotation_degrees", wiggle_amount, wiggle_time).from(0 - wiggle_amount).set_trans(
			Tween.TRANS_QUART)
