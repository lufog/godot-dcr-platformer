extends Area2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var stone_gate: StaticBody2D = $StoneGate

var is_switch_open := false


func _on_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		if not is_switch_open:
			right_switch_open()
		else:
			left_switch_close()


func left_switch_close():
	is_switch_open = false
	animated_sprite.play("close")
	stone_gate.close_stone_gate()


func right_switch_open():
	is_switch_open = true
	animated_sprite.play("open")
	stone_gate.open_stone_gate()
