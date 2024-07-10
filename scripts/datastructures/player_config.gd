class_name PlayerConfig
extends Resource

# Acceleration applied to x on horizontal movement
@export var WALK_ACCELERATION: float = 400

# Initial y speed when jumping
@export var INITIAL_JUMP_FORCE: float = 125

# Acceleration applied to y while jumping
@export var JUMP_ACCELERATION: float = 500

# How strong gravity affects the player
@export var GRAVITY_MULTIPLIER: float = 1.65

# Negative acceleration applied to current x direction (usually while not moving)
@export var HORIZONTAL_DRAG: float = 650

# Exponent applied to the exponential decay of the horizontal drag, causes slipperiness when increased
@export var SLIPPERINESS: float = 0.0

# How much the sprite is offset when the player is facing left
@export var SPRITE_FACING_LEFT_X_OFFSET: float = -14

# Acceleration multiplier applied to the walk acceleration while running
@export var RUNNING_ACCELERATION_MULTIPLIER: float = 1.75

# Maximum speed multiplier applied to the maximum (x) speed while running
@export var RUNNING_MAX_SPEED_MULTIPLIER: float = 1.35

# The maximum x velocity
@export var MAXIMUM_SPEED: float = 150

# Maximum y velocity
@export var TERMINAL_VELOCITY: float = 500

# How long after leaving the ground the player can still initiate the jump state
@export var COYOTE_TIME_SEC: float = 0.25

# For how long a jump input is buffered if it can't be applied in the current state
@export var JUMP_BUFFER_TIME_SEC: float = 0.15

# Maximum time the jump state will last when keeping jump pressed
@export var MAX_JUMP_TIME_SEC: float = 0.3

# Applied to the jump time of all jumps that are not the first jump after touching the ground
@export var FOLLOWUP_JUMP_MAX_JUMP_TIME_FACTOR: float = 0.5

# Applied to horizontal movement acceleration while jumping
@export var JUMP_MOVEMENT_FACTOR: float = 0.5

# Applied to horizontal movement acceleration while falling
@export var FALL_MOVEMENT_FACTOR: float = 0.5

# Applied to horizontal drag while idle
@export var IDLE_DRAG_MULTIPLIER: float = 3.0

# If x is immediately set to 0 when turning into the other direction
@export var INSTANT_TURN_AROUND: bool = true
