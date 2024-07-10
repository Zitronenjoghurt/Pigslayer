class_name JumpStatePlayer
extends State

@export var player: Player
@export var sprite: AnimatedSprite2D

var _jump_timer: float = 0.0

func enter():
	player.reset_jump_buffer()
	player.velocity.y = -player.config.INITIAL_JUMP_FORCE
	player.jumps_since_last_on_floor += 1
	_jump_timer = 0.0
	player.activate_jump_particles()

func update(delta: float):
	sprite.play("jump")
	
	if not Input.is_action_pressed("Up"):
		transition_state.emit(self, "fall")
		return
	
	var max_jump_time = player.config.MAX_JUMP_TIME_SEC
	if player.jumps_since_last_on_floor > 1:
		max_jump_time *= player.config.FOLLOWUP_JUMP_MAX_JUMP_TIME_FACTOR
	
	_jump_timer += delta
	if _jump_timer >= max_jump_time:
		transition_state.emit(self, "fall")
		return
	
	var jump_force = 1 - (_jump_timer / player.config.MAX_JUMP_TIME_SEC)
	player.process_jump(delta, jump_force)
	
	var has_moved = player.process_horizontal_movement(delta, player.config.JUMP_MOVEMENT_FACTOR)
	if not has_moved:
		player.process_horizontal_drag(delta)
	
	var max_speed_factor = 1.0
	if Input.is_action_pressed("Run"):
		max_speed_factor = player.config.RUNNING_MAX_SPEED_MULTIPLIER
	player.process_speed_limit(max_speed_factor)

func exit():
	player.deactivate_jump_particles()
