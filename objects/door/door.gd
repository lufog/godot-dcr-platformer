extends Area2D


@export var next_scene: PackedScene


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		SoundManager.level_complete_sound.play()
		SceneManager.change_scene(next_scene, SceneManager.Fades.DARK)
