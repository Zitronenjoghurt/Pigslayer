class_name Player
extends CharacterBody2D

@export var WALK_ACCELERATION: float = 500.0
@export var JUMP_ACCELERATION: float = 1500.0
@export var GRAVITY_MULTIPLIER: float = 1.75
@export var HORIZONTAL_DRAG: float = 650.0
@export var SLIPPERINESS: float = 0.0
@export var SPRITE_FACING_LEFT_X_OFFSET: float = -14.0
@export var RUNNING_ACCELERATION_MULTIPLIER: float = 1.6
@export var RUNNING_MAX_SPEED_MULTIPLIER: float = 1.2
@export var MAXIMUM_SPEED: float = 200.0
@export var TERMINAL_VELOCITY: float = 500.0
@export var COYOTE_TIME_SEC: float = 0.2
@export var JUMP_BUFFER_TIME_SEC: float = 0.15
@export var MAX_JUMP_TIME_SEC: float = 0.3
@export var JUMP_MOVEMENT_FACTOR: float = 0.5
@export var FALL_MOVEMENT_FACTOR: float = 0.5
@export var IDLE_DRAG_MULTIPLIER: float = 3.0

@onready var sprite: AnimatedSprite2D = %Sprite
@onready var camera: Camera2D = %Camera

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
	camera.limit_top = properties.camera_limit_top
	camera.limit_left = properties.camera_limit_left
	camera.limit_right = properties.camera_limit_right
	camera.limit_bottom = properties.camera_limit_bottom

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
			sprite.offset.x = SPRITE_FACING_LEFT_X_OFFSET
		FacingDirection.RIGHT:
			sprite.flip_h = false
			sprite.offset.x = 0

func process_jump_buffer(delta: float):
	if Input.is_action_just_pressed("Up"):
		_jump_buffer = JUMP_BUFFER_TIME_SEC
	if _jump_buffer == 0:
		return
	
	_jump_buffer -= delta
	if _jump_buffer < 0:
		reset_jump_buffer()
		
func reset_jump_buffer():
	_jump_buffer = 0.0

func is_jump_buffer_active() -> bool:
	return _jump_buffer > 0.0

func process_speed_limit(maximum_speed_factor: float = 1.0):
	velocity = Physics.limit_vector_x(velocity, MAXIMUM_SPEED * maximum_speed_factor)
	velocity = Physics.limit_vector_y(velocity, TERMINAL_VELOCITY)

func process_horizontal_drag(delta: float, drag_factor: float = 1.0, max_speed_factor: float = 1.0):
	velocity = Physics.apply_exp_decay_drag_x(delta, velocity, HORIZONTAL_DRAG * drag_factor, MAXIMUM_SPEED * max_speed_factor, SLIPPERINESS)

func process_gravity(delta: float, gravity_factor: float = 1.0):
	if not is_on_floor():
		velocity = Physics.apply_gravity(delta, velocity, GRAVITY_MULTIPLIER * gravity_factor)

# Returns true when movement was detected
func process_horizontal_movement(delta: float, acceleration_factor: float = 1.0) -> bool:
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x += delta * direction * WALK_ACCELERATION * acceleration_factor
		return true
	return false

func process_jump(delta: float, acceleration_factor: float = 1.0):
	velocity.y -= delta * JUMP_ACCELERATION * acceleration_factor
