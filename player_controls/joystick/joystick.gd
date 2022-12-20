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
			return
		
		var distance_to_center := (event_touch.position - button_area_node.global_position).length()
		if distance_to_center <= button_area_radius:
			finger_touch_index = event_touch.index
			global_position = event_touch.position - button_radius
		return
	
	var event_drag := event as InputEventScreenDrag
	if event_drag != null:
		if event_drag.index == finger_touch_index:
			var distance_to_center := (event_drag.position - button_area_node.global_position).length()
			if distance_to_center <= button_area_radius:
				global_position = event_drag.position - button_radius
			else:
				position = (event_drag.position - button_area_node.global_position).normalized() * button_area_radius - button_radius
		return
