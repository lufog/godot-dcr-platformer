class_name StateMachine extends Node


signal transitioned(state_name)

@export var initial_state: State

@onready var state := initial_state

func _ready() -> void:
	for child in get_children():
		var state := child as State
		if state == null:
			continue
		state.state_machine = self
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition_to(target_state: NodePath) -> void:
	if not has_node(target_state):
		return
	
	state.exit()
	state = get_node(target_state)
	state.enter()
	transitioned.emit(state.name)
