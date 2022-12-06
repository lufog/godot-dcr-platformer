class_name GroundButton extends StaticBody2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var unpressed_collision: CollisionPolygon2D = $UnpressedCollision
@onready var pressed_collision: CollisionPolygon2D = $PressedCollision
@onready var stone_gate: StaticBody2D = $StoneGate

var is_button_pressed := false


func press_button() -> void:
	is_button_pressed = true
	unpressed_collision.set_deferred("disabled", true)
	pressed_collision.set_deferred("disabled", false)
	animated_sprite.play("pressed")
	stone_gate.open_stone_gate()


func unpress_button() -> void:
	is_button_pressed = false
	unpressed_collision.set_deferred("disabled", false)
	pressed_collision.set_deferred("disabled", true)
	animated_sprite.play("unpressed")
	stone_gate.close_stone_gate()

func _on_press_detector_body_entered(body: Node2D) -> void:
	if body is RigidBox or body is Player:
		if is_button_pressed == false:
			press_button() 


func _on_press_detector_body_exited(body: Node2D) -> void:
	if body is RigidBox or body is Player: 
		if is_button_pressed == true:
			unpress_button()
