extends PlayerState


func enter() -> void:
	player.num_dashes -= 1
	player.is_dashing = true
	player.animation_state.travel("Dash")
	#SoundManager.dash_sound.play()


func exit() -> void:
	pass


func physics_update(_delta: float) -> void:
	var input_direction := Input.get_axis("ui_left", "ui_right")
	
	player.velocity.y = 0
	player.velocity.x = input_direction * player.dash_speed
	player.move_and_slide()
	
	if not player.is_dashing:
		if player.is_on_floor():
			state_machine.transition_to("IdleState")
		else:
			state_machine.transition_to("FallState")
