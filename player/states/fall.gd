class_name FallStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

func update(delta: float):
	if player.velocity.y <= 0:
		sprite.play("fall")
	else:
		sprite.play("jump")
	
	var has_moved = player.process_horizontal_movement(delta, player.config.FALL_MOVEMENT_FACTOR)
	if not has_moved:
		player.process_horizontal_drag(delta)
	
	player.process_gravity(delta)
	
	var max_speed_factor = 1.0
	if Input.is_action_pressed("Run"):
		max_speed_factor = player.config.RUNNING_MAX_SPEED_MULTIPLIER
	player.process_speed_limit(max_speed_factor)
	
	if player.is_on_floor():
		transition_state.emit(self, "idle")
		player.jumps_since_last_on_floor = 0
	elif player.jumps_since_last_on_floor == 1 and Input.is_action_just_pressed("Up"):
		transition_state.emit(self, "jump")

func exit():
	sprite.play("land")
