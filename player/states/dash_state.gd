extends PlayerState


func enter() -> void:
	player.num_dashes -= 1
	player.is_dashing = true
	player.animation_state.travel("Dash")
	#SoundManager.dash_sound.play()


func exit() -> void:
	pass


func physics_update(_delta: float) -> void:
	player.velocity.y = 0
	player.velocity.x = player.facing_direction * player.dash_speed
	player.move_and_slide()
	
	var collision_count := player.get_slide_collision_count()
	for i in collision_count:
		var _collision := player.get_slide_collision(i)
		var collider := _collision.get_collider()
		if collider is SpikeClub:
			state_machine.transition_to("DeathState")
			return
	
	if not player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("IdleState")
		else:
			state_machine.transition_to("FallState")
