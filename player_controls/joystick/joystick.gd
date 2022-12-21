extends TouchScreenButton


var button_radius := Vector2(8, 8)

@onready var button_area_node: Sprite2D = get_parent()
var button_area_radius := 18

var finger_touch_index := -1


func _input(event: InputEvent) -> void:
	var event_touch := event as InputEventScreenTouch
	if event_touch != null:
		if not event_touch.is_pressed() and event_touch.index == finger_touch_index:
			finger_touch_index = -1
			position = -button_radius
			set_player_action()
			return
		
		var distance_to_center := (event_touch.position - button_area_node.global_position).length()
		if distance_to_center <= button_area_radius:
			finger_touch_index = event_touch.index
			global_position = event_touch.position - button_radius
		set_player_action()
		return
	
	var event_drag := event as InputEventScreenDrag
	if event_drag != null:
		if event_drag.index == finger_touch_index:
			var distance_to_center := (event_drag.position - button_area_node.global_position).length()
			if distance_to_center <= button_area_radius:
				global_position = event_drag.position - button_radius
			else:
				position = (event_drag.position - button_area_node.global_position).normalized() * button_area_radius - button_radius
		set_player_action()
		return


func set_player_action() -> void:
	var pos_x := clampf(position.x + button_radius.x, -1, 1)
	print(action)
	
	if is_zero_approx(pos_x):
		Input.action_release("ui_left")
		Input.action_release("ui_right")
	elif pos_x < 0:
		Input.action_press("ui_left")
		Input.action_release("ui_right")
	elif pos_x > 0:
		Input.action_press("ui_right")
		Input.action_release("ui_left")

