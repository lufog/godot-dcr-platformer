class_name Enemy extends CharacterBody2D


enum States { WALK, DEATH }

@export var walk_speed := 15.0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var state := States.WALK
var input_direction_x: int

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite
@onready var collision: CollisionShape2D = $Collision
@onready var change_direction_timer: Timer = $ChangeDirectionTimer


func _ready() -> void:
	input_direction_x = 1
	change_direction_timer.start()


func _physics_process(delta: float) -> void:
	match state:
		States.WALK:
			animated_sprite.play("Walk")
			animated_sprite.flip_h = input_direction_x < 0
			velocity.x = walk_speed * input_direction_x
			apply_gravity(delta)
			move_and_slide()
			
			var collision_count := get_slide_collision_count()
			for i in collision_count:
				var _collision := get_slide_collision(i)
				var collider := _collision.get_collider()
				var player := collider as Player
				if player != null:
					player.state_machine.transition_to("DeathState")
					continue
				
			
		States.DEATH:
			animated_sprite.play("Death")
			collision.disabled = true
			await animated_sprite.animation_finished
			queue_free()

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func _on_change_direction_timer_timeout() -> void:
	input_direction_x = [-1, 1].pick_random()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area.owner is Player:
		state = States.DEATH
