class_name Player extends CharacterBody2D


enum States { IDLE, WALK, FALL, JUMP, ATTACK, DASH }

@export var jump_speed := 300.0
@export var walk_speed := 75.0
@export var dash_speed := 300.0
@export var num_dashes := 1

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_attacking := false
var is_dashing := false

var state := States.IDLE

@onready var sprite: Sprite2D = $Sprite
@onready var hitbox_marker: Marker2D = $HitboxMarker
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")


#func _physics_process(delta: float) -> void:
#	var input_direction := Input.get_axis("ui_left", "ui_right")
#
#	match state:
#		States.IDLE:
#			animation_state.travel("Idle")
#			if not is_equal_approx(input_direction, 0.0):
#				state = States.WALK
#		States.WALK:
#			animation_state.travel("Walk")
#			if is_equal_approx(input_direction, 0.0):
#				state = States.IDLE
#				continue
#
#			update_direction(input_direction)
#			velocity.x = walk_speed * input_direction
#			apply_gravity(delta)
#			move_and_slide()
#		States.FALL:
#			animation_state.travel("Fall")
#		States.JUMP:
#			animation_state.travel("Jump")
#		States.ATTACK:
#			animation_state.travel("Attack")
#		States.DASH:
#			animation_state.travel("Dash")


func on_attack_finished() -> void:
	is_attacking = false


func on_dash_finished() -> void:
	is_dashing = false


func reset_dash_counter(value: int) -> void:
	num_dashes = value


func has_dashes() -> bool:
	return num_dashes > 0


func update_direction(input_direction: float) -> void:
	if input_direction > 0:
		hitbox_marker.rotation = deg_to_rad(0)
		sprite.flip_h = false
	else:
		hitbox_marker.rotation = deg_to_rad(180)
		sprite.flip_h = true


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
