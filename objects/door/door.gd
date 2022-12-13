extends Area2D


@export var next_scene: PackedScene

@onready var _scene_tree := get_tree()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		_scene_tree.change_scene_to_packed(next_scene)
