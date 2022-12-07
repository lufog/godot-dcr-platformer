extends PlayerState


func enter() -> void:
	player.velocity.y = -player.jump_speed
	player.animation_state.travel("Jump")


func exit() -> void:
	pass


func physics_update(delta: float) -> void:
	if player.velocity.y > 0:
		state_machine.transition_to("FallState")
		return
		
	var input_direction_x := Input.get_axis("ui_left", "ui_right")
	
	if not is_zero_approx(input_direction_x):
		player.update_direction(input_direction_x)
		player.velocity.x = player.walk_speed * input_direction_x
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	var collision_count := player.get_slide_collision_count()
	for i in collision_count:
		var _collision := player.get_slide_collision(i)
		var collider := _collision.get_collider()
		if collider is SpikeClub:
			state_machine.transition_to("DeathState")
			return
	
	if Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("DashState")
