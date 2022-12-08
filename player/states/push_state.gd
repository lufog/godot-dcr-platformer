extends PlayerState


func enter() -> void:
	player.animation_state.travel("Push")


func exit() -> void:
	pass


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("FallState")
	
	var input_direction_x := Input.get_axis("ui_left", "ui_right")
	
	if is_zero_approx(input_direction_x):
		state_machine.transition_to("IdleState")
		return
	
	player.update_direction(input_direction_x)
	player.velocity.x = player.walk_speed * input_direction_x
	player.apply_gravity(delta)
	player.move_and_slide()
	
	var collision_count := player.get_slide_collision_count()
	for i in collision_count:
		var _collision := player.get_slide_collision(i)
		var box := _collision.get_collider() as RigidBox
		if box != null:
			box.apply_central_impulse(-_collision.get_normal() * player.rigid_push)
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpState")
