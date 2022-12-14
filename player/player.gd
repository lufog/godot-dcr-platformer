class_name Player extends CharacterBody2D


enum States { IDLE, WALK, FALL, JUMP, ATTACK, DASH }

@export var jump_speed := 300.0
@export var walk_speed := 75.0
@export var dash_speed := 300.0
@export var num_dashes := 1

var rigid_push := Vector2(240, 0)

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_direction: int
var is_attacking := false
var is_dashing := false

var state := States.IDLE

@onready var sprite: Sprite2D = $Sprite
@onready var hitbox_marker: Marker2D = $HitboxMarker
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
@onready var state_machine: Node = $StateMachine


func _ready() -> void:
	update_direction(1)


func on_attack_finished() -> void:
	is_attacking = false


func on_dash_finished() -> void:
	is_dashing = false


func reset_dash_counter(value: int) -> void:
	num_dashes = value


func has_dashes() -> bool:
	return num_dashes > 0


func play_death_sound() -> void:
	SoundManager.death_sound.play()


func update_direction(input_direction: float) -> void:
	if input_direction > 0:
		facing_direction = 1
		sprite.flip_h = false
		hitbox_marker.rotation = deg_to_rad(0)
	else:
		facing_direction = -1
		sprite.flip_h = true
		hitbox_marker.rotation = deg_to_rad(180)


func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta


func restart_level() -> void:
	pass
