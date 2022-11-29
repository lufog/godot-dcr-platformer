extends PlayerState


func enter() -> void:
	player.animation_state.travel("Fall")


func exit() -> void:
	pass


func physics_update(delta: float) -> void:
	if player.is_on_floor():
		state_machine.transition_to("IdleState")
		return
	
	var input_direction_x := Input.get_axis("ui_left", "ui_right")
	
	if not is_zero_approx(input_direction_x):
		player.update_direction(input_direction_x)
		player.velocity.x = player.walk_speed * input_direction_x
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	if Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("DashState")
