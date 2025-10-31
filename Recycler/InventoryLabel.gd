extends Label

const TEXT_COLOR = Color(0.0, 0.0, 0.0) # TODO: Set up themes
var isTweening : bool = false

func set_up(item):
	pivot_offset.x = size.x/2
	pivot_offset.y = size.y/2
	name = item + '_label'
	text = item + ' : ' + '1'
	add_theme_color_override("font_color", TEXT_COLOR)
	isTweening = true
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", Vector2(1, 1), 0.25).set_trans(Tween.TRANS_BACK).from(Vector2())
	tween.tween_callback(func(): isTweening = false)

func update(item, count):
	text = item + ' : ' + str(count)
	if isTweening:
		return
	var tween =  get_tree().create_tween()
	isTweening = true
	var start_pos = position
	position = Vector2(start_pos.x, start_pos.y - 10)
	tween.tween_property(
		self, "position", start_pos, 0.25).set_trans(Tween.TRANS_BACK)
	tween.tween_callback(func(): isTweening = false)

func remove_ui(callback):
	isTweening = true
	var tween = get_tree().create_tween()
	tween.tween_property(
		self, "scale", Vector2(0, 0), 0.25).set_trans(Tween.TRANS_BACK).from(Vector2(1, 1))
	tween.tween_callback(callback)

