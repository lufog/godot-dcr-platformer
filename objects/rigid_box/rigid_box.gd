class_name RigidBox extends RigidBody2D


var max_speed := 20.0


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if linear_velocity.length() > max_speed:
		linear_velocity.limit_length(max_speed)
