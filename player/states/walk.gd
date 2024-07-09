class_name WalkStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

var _coyote_timer: float = 0.0

func enter():
	_coyote_timer = 0.0

func update(delta: float):
	sprite.play("run")
	
	var acceleration_factor: float = 1.0
	var max_speed_factor: float = 1.0
	if Input.is_action_pressed("Run"):
		acceleration_factor = player.RUNNING_ACCELERATION_MULTIPLIER
		max_speed_factor = player.RUNNING_MAX_SPEED_MULTIPLIER
	
	var has_moved = player.process_horizontal_movement(delta, acceleration_factor)
	player.process_speed_limit(max_speed_factor)
	
	if not has_moved:
		player.process_horizontal_drag(delta, 1.0, acceleration_factor)
	
	player.process_gravity(delta)
	
	if player.velocity.x == 0 and player.is_on_floor():
		transition_state.emit(self, "idle")
		return
	
	if not player.is_on_floor():
		_coyote_timer += delta
	else:
		_coyote_timer = 0.0

	if _coyote_timer <= player.COYOTE_TIME_SEC and player.is_jump_buffer_active():
		transition_state.emit(self, "jump")
		return
	
	if _coyote_timer > player.COYOTE_TIME_SEC:
		transition_state.emit(self, "fall")
