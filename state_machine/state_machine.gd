class_name StateMachine extends Node


signal transitioned(state_name)

@export var initial_state: State

@onready var current_state := initial_state

func _ready() -> void:
	await owner.ready
	
	for child in get_children():
		var state := child as State
		if state == null:
			continue
		state.state_machine = self
	current_state.enter()


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func _process(delta: float) -> void:
	current_state.update(delta)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func transition_to(target_state: NodePath) -> void:
	if not has_node(target_state):
		return
	
	current_state.exit()
	current_state = get_node(target_state)
	current_state.enter()
	transitioned.emit(current_state.name)
