extends PlayerState


func enter() -> void:
	player.velocity.x = 0
	player.animation_state.travel("Idle")
	if player.has_dashes():
		player.reset_dash_counter(1)


func exit() -> void:
	pass


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("FallState")
			return
	
	player.apply_gravity(delta)
	player.move_and_slide()
	
	# Handle collisions in future.
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpState")
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.transition_to("WalkState")
	elif Input.is_action_pressed("attack"):
		state_machine.transition_to("AttackState")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("DashState")
