extends CharacterBody2D


var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var ray_cast: RayCast2D = $RayCast


var is_stuck := true


func _physics_process(delta: float) -> void:
	if not is_stuck:
		apply_gravity(delta)
		move_and_slide()
	
	if ray_cast.is_colliding():
		if ray_cast.collide_with_bodies:
			var collider = ray_cast.get_collider()
			if collider is Player:
				is_stuck = false
	
	for i in get_slide_collision_count():
		var collision := get_slide_collision(i)
		var collider := collision.get_collider()
		if collider is TileMap:
			is_stuck = true
			set_physics_process(false)
		var player := collider as Player
		if player != null:
			player.state_machine.transition_to("DeathState")


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
