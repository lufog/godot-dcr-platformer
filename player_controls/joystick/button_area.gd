extends Sprite2D


func _ready() -> void:
	if not DisplayServer.is_touchscreen_available():
		hide()
