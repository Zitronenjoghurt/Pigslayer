class_name Player
extends CharacterBody2D

@export var SPEED: float = 300.0
@export var JUMP_VELOCITY: float = -400.0
@export var HORIZONTAL_DRAG: float = 5000.0

func _physics_process(delta):
	if not is_on_floor():
		velocity = Physics.apply_gravity(delta, velocity)
	
	velocity = Physics.apply_drag_x(delta, velocity, HORIZONTAL_DRAG)

	move_and_slide()
