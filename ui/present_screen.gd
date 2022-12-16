extends TextureRect


@export var next_scene: PackedScene

var duration := 1.0

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.wait_time = SceneManager.get_anim_duration() + duration
	timer.start()


func _on_timer_timeout() -> void:
	SceneManager.change_scene(next_scene, SceneManager.Fades.LIGHT)
