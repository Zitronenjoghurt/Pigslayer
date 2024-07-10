class_name PlayerConfig
extends Resource

# Acceleration applied to x on horizontal movement
@export var WALK_ACCELERATION: float

# Initial y speed when jumping
@export var INITIAL_JUMP_FORCE: float

# Acceleration applied to y while jumping
@export var JUMP_ACCELERATION: float

# How strong gravity affects the player
@export var GRAVITY_MULTIPLIER: float

# Negative acceleration applied to current x direction (usually while not moving)
@export var HORIZONTAL_DRAG: float

# Exponent applied to the exponential decay of the horizontal drag, causes slipperiness when increased
@export var SLIPPERINESS: float

# How much the sprite is offset when the player is facing left
@export var SPRITE_FACING_LEFT_X_OFFSET: float

# Acceleration multiplier applied to the walk acceleration while running
@export var RUNNING_ACCELERATION_MULTIPLIER: float

# Maximum speed multiplier applied to the maximum (x) speed while running
@export var RUNNING_MAX_SPEED_MULTIPLIER: float

# The maximum x velocity
@export var MAXIMUM_SPEED: float

# Maximum y velocity
@export var TERMINAL_VELOCITY: float

# How long after leaving the ground the player can still initiate the jump state
@export var COYOTE_TIME_SEC: float

# For how long a jump input is buffered if it can't be applied in the current state
@export var JUMP_BUFFER_TIME_SEC: float

# Maximum time the jump state will last when keeping jump pressed
@export var MAX_JUMP_TIME_SEC: float

# Applied to horizontal movement acceleration while jumping
@export var JUMP_MOVEMENT_FACTOR: float

# Applied to horizontal movement acceleration while falling
@export var FALL_MOVEMENT_FACTOR: float

# Applied to horizontal drag while idle
@export var IDLE_DRAG_MULTIPLIER: float

# If x is immediately set to 0 when turning into the other direction
@export var INSTANT_TURN_AROUND: bool
