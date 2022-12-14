extends PlayerState


func enter() -> void:
	player.animation_state.travel("Walk")


func exit() -> void:
	pass


func physics_update(delta: float) -> void:
	if not player.is_on_floor():
		if player.velocity.y > 0:
			state_machine.transition_to("FallState")
			return
	
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
		var collider := _collision.get_collider()
		if collider is SpikePit:
			if _collision.get_normal().y == -1:
				state_machine.transition_to("DeathState")
				return
		if collider is SpikeClub:
			state_machine.transition_to("DeathState")
			return
		elif collider is RigidBox and player.is_on_wall():
			state_machine.transition_to("PushState")
		
	
	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("JumpState")
	elif Input.is_action_pressed("attack"):
		state_machine.transition_to("AttackState")
	elif Input.is_action_just_pressed("dash") and player.has_dashes():
		state_machine.transition_to("DashState")
