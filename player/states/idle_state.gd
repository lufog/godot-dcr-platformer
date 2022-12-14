extends PlayerState


func enter() -> void:
	player.velocity.x = 0
	player.animation_state.travel("Idle")
	if not player.has_dashes():
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
	
	var collision_count := player.get_slide_collision_count()
	for i in collision_count:
		var _collision := player.get_slide_collision(i)
		var collider := _collision.get_collider()
		if collider is SpikeClub:
			state_machine.transition_to("DeathState")
			return
		if collider is SpikePit:
			if _collision.get_normal().y == -1:
				state_machine.transition_to("DeathState")
				return
	
	# Handle collisions in future.
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpState")
	elif Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine.transition_to("WalkState")
	elif Input.is_action_pressed("attack"):
		state_machine.transition_to("AttackState")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("DashState")
