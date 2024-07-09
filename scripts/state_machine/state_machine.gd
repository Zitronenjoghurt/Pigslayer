class_name StateMachine
extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if not child is State:
			continue
		if child.name in states:
			continue
		states[child.name.to_lower()] = child
		child.transition_state.connect(_on_state_transition)
		
	if initial_state is State:
		initial_state.enter()
		current_state = initial_state
		
func _on_state_transition(old_state: State, new_state: String):
	if old_state != current_state:
		return

	if new_state not in states:
		print("Invalid state: " + new_state)
		return
	
	var transition_to_state: State = states[new_state.to_lower()] as State
	current_state = null
	old_state.exit()
	transition_to_state.enter()
	current_state = transition_to_state

func _physics_process(delta):
	if current_state is State:
		current_state.update(delta)
