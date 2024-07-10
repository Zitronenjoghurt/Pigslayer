class_name Player
extends CharacterBody2D

@export var config: PlayerConfig

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var camera: Camera2D = %Camera
@onready var jump_particles: CPUParticles2D = %JumpParticles

enum FacingDirection {
	LEFT,
	RIGHT
}

var current_facing_direction: FacingDirection = FacingDirection.RIGHT
var jumps_since_last_on_floor: int = 0
var _jump_buffer: float = 0.0

func _physics_process(delta):
	update_facing_direction()
	process_jump_buffer(delta)
	move_and_slide()
	
func on_spawn(properties: PlayerSpawnProperties):
	global_position = properties.spawn_position
	properties.camera_limits.apply_limits(camera)

func update_facing_direction():
	if velocity.x > 0:
		current_facing_direction = FacingDirection.RIGHT
		set_sprite_facing_direction(FacingDirection.RIGHT)
	elif velocity.x < 0:
		current_facing_direction = FacingDirection.LEFT
		set_sprite_facing_direction(FacingDirection.LEFT)

func set_sprite_facing_direction(direction: FacingDirection):
	match direction:
		FacingDirection.LEFT:
			sprite.flip_h = true
			sprite.offset.x = config.SPRITE_FACING_LEFT_X_OFFSET
		FacingDirection.RIGHT:
			sprite.flip_h = false
			sprite.offset.x = 0

func process_jump_buffer(delta: float):
	if Input.is_action_just_pressed("Up"):
		_jump_buffer = config.JUMP_BUFFER_TIME_SEC
	if _jump_buffer == 0:
		return
	
	_jump_buffer -= delta
	if _jump_buffer < 0:
		reset_jump_buffer()
		
func reset_jump_buffer():
	_jump_buffer = 0.0

func is_jump_buffer_active() -> bool:
	return _jump_buffer > 0.0

func process_speed_limit(maximum_speed_factor: float=1.0):
	velocity = Physics.limit_vector_x(velocity, config.MAXIMUM_SPEED * maximum_speed_factor)
	velocity = Physics.limit_vector_y(velocity, config.TERMINAL_VELOCITY)

func process_horizontal_drag(delta: float, drag_factor: float=1.0, max_speed_factor: float=1.0):
	velocity = Physics.apply_exp_decay_drag_x(delta, velocity, config.HORIZONTAL_DRAG * drag_factor, config.MAXIMUM_SPEED * max_speed_factor, config.SLIPPERINESS)

func process_gravity(delta: float, gravity_factor: float=1.0):
	if not is_on_floor():
		velocity = Physics.apply_gravity(delta, velocity, config.GRAVITY_MULTIPLIER * gravity_factor)

# Returns true when movement was detected
func process_horizontal_movement(delta: float, acceleration_factor: float=1.0) -> bool:
	var direction = Input.get_axis("Left", "Right")
	
	if config.INSTANT_TURN_AROUND:
		if direction == 1 and velocity.x < 0:
			velocity.x = 0
		elif direction == - 1 and velocity.x > 0:
			velocity.x = 0
	
	if direction:
		velocity.x += delta * direction * config.WALK_ACCELERATION * acceleration_factor
		return true
	return false

func process_jump(delta: float, acceleration_factor: float=1.0):
	velocity.y -= delta * config.JUMP_ACCELERATION * acceleration_factor

# VISUALS
func activate_jump_particles():
	jump_particles.emitting = true

func deactivate_jump_particles():
	jump_particles.emitting = false
